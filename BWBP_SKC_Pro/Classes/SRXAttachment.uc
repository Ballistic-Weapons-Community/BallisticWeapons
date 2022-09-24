class SRXAttachment extends BallisticAttachment;

var() class<BCImpactManager>ImpactManagerAmp1;		
var() class<BCImpactManager>ImpactManagerAmp2;		
var() class<BCTraceEmitter>	TracerClassAmp1;		
var() class<BCTraceEmitter>	TracerClassAmp2;		
var() class<actor>			MuzzleFlashClassAmp1;	
var   actor					MuzzleFlashAmp1;		
var() class<actor>			MuzzleFlashClassAmp2;
var   actor					MuzzleFlashAmp2;	

var() array<Material> CamoMaterials; //We're using this for the amp
	
var bool		bAmp1, bOldAmp1;	//red
var bool		bAmp2, bOldAmp2;	//green
var bool		bAmped, bOldAmped;
var bool		bSilenced, bOldSilenced;

replication
{
	reliable if ( Role==ROLE_Authority )
		bAmp1, bAmp2, bAmped, bSilenced;
}

//Do your camo changes here
simulated function PostNetBeginPlay()
{
	SetBoneScale (0, 0.0, 'Silencer');
	SetBoneScale (1, 0.0, 'AMP');
}

simulated event PostNetReceive()
{
	if (bSilenced != bOldSilenced)	//silenced
	{
		bOldSilenced = bSilenced;
		if (bSilenced)
			SetBoneScale (0, 1.0, 'Silencer');
		else
			SetBoneScale (0, 0.0, 'Silencer');
	}

	if (bAmped != bOldAmped)	//amped
	{
		bOldAmped = bAmped;
		if (bAmped)
			SetBoneScale (1, 1.0, 'AMP');
		else
			SetBoneScale (1, 0.0, 'AMP');
	}
	if (bAmp1 != bOldAmp1)	//red amp
	{
		bOldAmp1 = bAmp1;
		if (bAmped && bAmp1)
		{
			Skins[13]=CamoMaterials[0];
			Skins[14]=CamoMaterials[2];
		}
	}
	if (bAmp2 != bOldAmp2)	//green amp
	{
		bOldAmp2 = bAmp2;
		if (bAmped && bAmp2)
		{
			Skins[13]=CamoMaterials[1];
			Skins[14]=CamoMaterials[3];
		}
	}
	Super.PostNetReceive();
}

simulated function SetSilenced(bool bIsSilenced)
{
	bSilenced = bIsSilenced;
	
	if (bSilenced)
		SetBoneScale (0, 1.0, 'Silencer');
	else
		SetBoneScale (0, 0.0, 'Silencer');
}

simulated function SetAmped(bool bIsAmped)
{
	bAmped = bIsAmped;
	
	if (bAmped)
		SetBoneScale (1, 1.0, 'AMP');
	else
		SetBoneScale (1, 0.0, 'AMP');
}

simulated event ThirdPersonEffects()
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (bSilenced)
		{
			SetBoneScale (0, 1.0, 'Silencer');
			SetBoneScale (1, 0.0, 'AMP');
		}
		else if (bAmped)
		{
			SetBoneScale (0, 0.0, 'Silencer');
			SetBoneScale (1, 1.0, 'AMP');
		}
		else
		{
			SetBoneScale (0, 0.0, 'Silencer');
			SetBoneScale (0, 0.0, 'AMP');			
		}
    }
	super.ThirdPersonEffects();
}

simulated function SetAmpColour(bool bIsAmp1, bool bIsAmp2)
{
	bAmp1 = bIsAmp1;
	bAmp2 = bIsAmp2;
	
	//set skins
	if (bAmped && bAmp1)	//red amp
	{
		Skins[13]=CamoMaterials[0];
		Skins[14]=CamoMaterials[2];
	}
	if (bAmped && bAmp2)	//green amp
	{
		Skins[13]=CamoMaterials[1];
		Skins[14]=CamoMaterials[3];
	}
}

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z;

	if (Instigator != None && Instigator.IsFirstPerson())
	{
		if (SRXRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			return Instigator.Weapon.GetEffectStart();
	}
	else
		return GetBoneCoords('tip').Origin;
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
		
	if (ImpactManagerAmp1 != None && bAmped && bAmp1)
		ImpactManagerAmp1.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else if (ImpactManagerAmp2 != None && bAmped && bAmp2)
		ImpactManagerAmp2.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
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
	if (TracerClassAmp1 != None && bThisShot && bAmp1 && bAmped)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAmp1, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	if (TracerClassAmp2 != None && bThisShot && bAmp2 && bAmped)
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClassAmp2, self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	if (TracerClass != None && bThisShot && Mode == 0 && !bAmped && !bSilenced)
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

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;
	if (bRandomFlashRoll)
		R.Roll = Rand(65536);
		
	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	
	if (MuzzleFlashClassAmp1 != None && bAmp1 && bAmped)
	{
		if (MuzzleFlashAmp1 == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp1, MuzzleFlashClassAmp1, DrawScale*0.1, self, AltFlashBone);
		MuzzleFlashAmp1.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (MuzzleFlashClassAmp2 != None && bAmp2 && bAmped)
	{
		if (MuzzleFlashAmp2 == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp2, MuzzleFlashClassAmp2, DrawScale*0.1, self, AltFlashBone);
		MuzzleFlashAmp2.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (AltMuzzleFlashClass != None && !bAmped && bSilenced)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*0.1, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	if (MuzzleFlashClass != None && Mode == 0 && !bAmped && !bSilenced)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*0.1, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
	}
}

defaultproperties
{
	 CamoMaterials[0]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalRed'
	 CamoMaterials[1]=Shader'BW_Core_WeaponTex.Amp.Amp-FinalGreen'
	 CamoMaterials[2]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowRedShader'
	 CamoMaterials[3]=Shader'BW_Core_WeaponTex.AMP.Amp-GlowGreenShader'
	 
     MuzzleFlashClassAmp1=Class'BWBP_SKC_Pro.SRXFlashEmitter'
     MuzzleFlashClassAmp2=Class'BallisticProV55.A500FlashEmitter'
	 
     ImpactManagerAmp1=Class'BWBP_SKC_Pro.IM_BulletAmpInc'
     ImpactManagerAmp2=Class'BWBP_SKC_Pro.IM_BulletAcid'
	 
	 TracerClassAmp1=Class'BWBP_SKC_Pro.TraceEmitter_HMG'
     TracerClassAmp2=Class'BWBP_SKC_Pro.TraceEmitter_Tranq'
	 
	 MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     AltMuzzleFlashClass=Class'BWBP_SKC_Pro.SRXSilencedFlash'
     AltFlashBone="tip2"
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=0.900000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
	 DrawScale=0.800000
     RelativeRotation=(Pitch=32768)
	 Mesh=SkeletalMesh'BWBP_OP_Anim.SRX_TPm'
}
