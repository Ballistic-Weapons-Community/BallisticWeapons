//=============================================================================
// FMP Attachment
//
// FMP-2012's 3rd
//=============================================================================
class FMPAttachment extends BallisticAttachment;

var() class<BCImpactManager>ImpactManagerRed;		//Impact Manager to use for iATLATmpact effects
var() class<BCImpactManager>ImpactManagerGreen;		//Impact Manager to use for iATLATmpact effects
var() class<BCTraceEmitter>	TracerClassRed;			//Type of tracer to use for alt fire effects
var() class<BCTraceEmitter>	TracerClassGreen;		//Type of tracer to use for alt fire effects
var() class<actor>			MuzzleFlashClassRed;	//Effect to spawn fot mode 0 muzzle flash
var   actor					MuzzleFlashRed;			//The flash actor itself
var() class<actor>			MuzzleFlashClassGreen;	//Effect to spawn fot mode 1 muzzle flash
var   actor					MuzzleFlashGreen;		//The flash actor itself
var   float					AmpFlashScale;			
var   Rotator				AltTipRotation;

var() array<Material> CamoMaterials; //We're using this for the amp

var bool		bRedAmp, bOldRedAmp;
var bool		bGreenAmp, bOldGreenAmp;
var bool		bAmped, bOldAmped;

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		bRedAmp, bGreenAmp, bAmped;
}

//Do your camo changes here
simulated function PostNetBeginPlay()
{
	SetBoneScale (0, 0.0, 'AMP');
	SetBoneRotation ('tip2',AltTipRotation);
}

simulated event PostNetReceive()
{
	if (bAmped != bOldAmped)
	{
		bOldAmped = bAmped;
		if (bAmped)
			SetBoneScale (0, 1.0, 'AMP');
		else
			SetBoneScale (0, 0.0, 'AMP');
	}
	if (bRedAmp != bOldRedAmp)	//explosive
	{
		bOldRedAmp = bRedAmp;
		if (bAmped && bRedAmp)
		{
			Skins[2]=CamoMaterials[0];
			Skins[3]=CamoMaterials[2];
		}
	}
	if (bGreenAmp != bOldGreenAmp)	//corrosive
	{
		bOldGreenAmp = bGreenAmp;
		if (bAmped && bGreenAmp)
		{
			Skins[2]=CamoMaterials[1];
			Skins[3]=CamoMaterials[3];
		}
	}
	Super.PostNetReceive();
}

simulated function SetAmped(bool bIsAmped)
{
	bAmped = bIsAmped;
	
	if (bAmped)
		SetBoneScale (0, 1.0, 'AMP');
	else
		SetBoneScale (0, 0.0, 'AMP');
}

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (bAmped)
			SetBoneScale (0, 1.0, 'AMP');
		else
			SetBoneScale (0, 0.0, 'AMP');
    }
	super.ThirdPersonEffects();
}

simulated function SetAmpColour(bool bIsRedAmp, bool bIsGreenAmp)
{
	bRedAmp = bIsRedAmp;
	bGreenAmp = bIsGreenAmp;
	
	//set skins
	if (bAmped && bRedAmp)	//explosive
	{
		Skins[2]=CamoMaterials[0];
		Skins[3]=CamoMaterials[2];
	}
	if (bAmped && bGreenAmp)	//corrosive
	{
		Skins[2]=CamoMaterials[1];
		Skins[3]=CamoMaterials[3];
	}
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode == 0) || (InstantMode == MU_Primary && Mode != 0))
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;
	SpawnTracer(Mode, mHitLocation);
	FlyByEffects(Mode, mHitLocation);
	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();

		if (WallPenetrates != 0)				{
			WallPenetrates = 0;
			DoWallPenetrate(Mode, Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		// Check for water and spawn splash
		if (ImpactManager!= None && bDoWaterSplash)
			DoWaterTrace(Mode, Start, mHitLocation);

		if (mHitActor == None)
			return;
		// Set the hit surface type
		if (Vehicle(mHitActor) != None)
			mHitSurf = 3;
		else if (HitMat == None)
			mHitSurf = int(mHitActor.SurfaceType);
		else
			mHitSurf = int(HitMat.SurfaceType);
	}
	// Server has all the info already...
 	else
		HitLocation = mHitLocation;

	if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
		ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
		
	if (ImpactManagerRed != None && bAmped && bRedAmp)
		ImpactManagerRed.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else if (ImpactManagerGreen != None && bAmped && bGreenAmp)
		ImpactManagerGreen.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetModeTipLocation();
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (TracerMix == 0)
		bThisShot=true;
	else
	{
		TracerCounter++;
		if (TracerMix < 0)
		{
			if (TracerCounter >= -TracerMix)	{
				TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (TracerCounter >= TracerMix)	{
			TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer
	if (TracerClassRed != None && bThisShot && bRedAmp && bAmped)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassRed, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn a tracer
	if (TracerClassGreen != None && bThisShot && bGreenAmp && bAmped)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassGreen, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	else if (TracerClass != None && bThisShot && Mode == 0 && !bAmped)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode != 0) || (WaterTracerMode == MU_Primary && Mode == 0)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (MuzzleFlashClassRed != None && bRedAmp && bAmped)
	{
		if (MuzzleFlashRed == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlashRed, MuzzleFlashClassRed, DrawScale*AmpFlashScale, self, AltFlashBone);
		MuzzleFlashRed.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (MuzzleFlashClassGreen != None && bGreenAmp && bAmped)
	{
		if (MuzzleFlashGreen == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlashGreen, MuzzleFlashClassGreen, DrawScale*AmpFlashScale, self, AltFlashBone);
		MuzzleFlashGreen.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (MuzzleFlashClass != None && Mode == 0 && !bAmped)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

defaultproperties
{
	WeaponClass=class'FMPMachinePistol'
	AmpFlashScale=0.2
	CamoMaterials[0]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalRed'
	CamoMaterials[1]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalGreen'
	CamoMaterials[2]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowRedShader'
	CamoMaterials[3]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowGreenShader'

	AltFlashBone="tip2"
	AltTipRotation=(Pitch=16384)
	MuzzleFlashClass=Class'BWBP_SKC_Pro.FMPFlashEmitter'
	ImpactManager=class'IM_Bullet'
	
	MuzzleFlashClassRed=Class'BWBP_SKC_Pro.SRXFlashEmitter'
	MuzzleFlashClassGreen=class'A500FlashEmitter'
	
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_MARS'
	TracerClassRed=Class'BWBP_SKC_Pro.TraceEmitter_HMG'
	TracerClassGreen=Class'BWBP_SKC_Pro.TraceEmitter_Tranq'
	
	ImpactManagerRed=Class'BWBP_SKC_Pro.IM_BulletHE'
	ImpactManagerGreen=Class'BWBP_SKC_Pro.IM_BulletAmpAcid'
	
	BrassClass=class'Brass_Rifle'
	InstantMode=MU_Both
	FlashMode=MU_Both
	LightMode=MU_Both
	FlashScale=0.5
	TracerMix=0
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	bRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.MP40_TPm'
	RelativeRotation=(Yaw=32768,Roll=-16384)
	RelativeLocation=(Z=7)
	DrawScale=0.35000
}
