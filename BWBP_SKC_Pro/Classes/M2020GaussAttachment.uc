//=============================================================================
// M2020Attachment.
//
// 3rd person weapon attachment for M2020 Gauss Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M2020GaussAttachment extends BallisticAttachment;

var byte CurrentTracerMode;
var array< class<BCTraceEmitter> >	TracerClasses[4]; //Offline, suppressed, gauss, overcharged
var array< class<BCImpactManager> >	ImpactManagers[4];

var   bool					bLaserOn;		//Is laser currently active
var   bool					bOldLaserOn;	//Old bLaserOn
var   LaserActor			Laser;			//The laser actor
var   Rotator				LaserRot;
var	BallisticWeapon	myWeap;

var	 Vector				SpawnOffset;

var  byte 				OldBlockEffectCount, BlockEffectCount;
var  M2020BlockEffect 		M2020BlockEffect;


replication
{
	reliable if ( Role==ROLE_Authority )
		BlockEffectCount, bLaserOn, CurrentTracerMode;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
	
	if (M2020GaussDMR(I) != None && (M2020GaussDMR(I).CurrentWeaponMode == 2 || M2020GaussDMR(I).CurrentWeaponMode == 3))
	{
		CurrentTracerMode=0;
	}
	if (M2020GaussDMR(I) != None && M2020GaussDMR(I).bSuppressed)
	{
		CurrentTracerMode=1;
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

		if (WallPenetrates != 0)
		{
			WallPenetrates = 0;
			DoWallPenetrate(Mode, Start, mHitLocation);	
		}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		// Check for water and spawn splash
		if (ImpactManagers[CurrentTracerMode] != None && bDoWaterSplash)
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
	if (ImpactManagers[CurrentTracerMode] != None)
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

// Spawn some wall penetration effects...
simulated function WallPenetrateEffect(byte Mode, vector HitLocation, vector HitNormal, int HitSurf, optional bool bExit)
{
	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0 || level.NetMode == NM_DedicatedServer || ImpactManagers[CurrentTracerMode] == None)
		return;
	if (bExit && (Level.DetailMode == DM_High || class'BallisticMod'.default.EffectsDetailMode == 1) )
		return;
	if (bExit)
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator, 2/*HF_NoSound*/);
	else
		ImpactManagers[CurrentTracerMode].static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator);
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);


		if (Dist > 200)
			Tracer = Spawn(TracerClasses[CurrentTracerMode], self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
		
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

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && myWeap != None)
	{
		LaserRot = Instigator.GetViewRotation();
		LaserRot += myWeap.GetAimPivot();
		LaserRot += myWeap.GetRecoilPivot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_Third',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
	}

	if (Instigator != None)
		Start = Instigator.Location + Instigator.EyePosition();
	else
		Start = Location;
	X = LaserRot;

//	Loc = GetModeTipLocation();
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + (Vector(X)*5000);
	Other = Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (M2020GaussDMR(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetEffectStart();
	}
	else
		Loc = GetBoneCoords('tip').Origin;

    return Loc;
}

simulated function PostNetReceive()
{
	if (OldBlockEffectCount != BlockEffectCount)
	{
		OldBlockEffectCount = BlockEffectCount;
		DoBlockEffect();
	}

    Super.PostNetReceive();
}

simulated function DoBlockEffect()
{	
	Spawn(class'M2020BlockEffect',Instigator,,GetModeTipLocation(), Instigator.GetViewRotation());
}

simulated function Destroyed()
{
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'M2020GaussDMR'
	
	TracerClasses(0)=class'TraceEmitter_Default'
	TracerClasses(1)=class'TraceEmitter_AP'
	TracerClasses(2)=class'TraceEmitter_Gauss'
	TracerClasses(3)=class'TraceEmitter_GaussSuper'
	ImpactManagers(0)=class'IM_Bullet'
	ImpactManagers(1)=class'IM_BulletGauss'
	ImpactManagers(2)=class'IM_BulletGauss'
	ImpactManagers(3)=class'IM_BulletGauss'
	
	Mesh=SkeletalMesh'BWBP_SKC_Anim.M2020_TPm'
	MuzzleFlashClass=class'BWBP_SKC_Pro.M2020FlashEmitter'
	AltMuzzleFlashClass=class'M806FlashEmitter'
	ImpactManager=class'IM_Bullet'
	BrassClass=class'Brass_Rifle'
	InstantMode=MU_Both
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_GaussSuper'
	TracerChance=2.000000
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	AmbientSound=Sound'BW_Core_WeaponSound.M75.M75Hum'
	SoundVolume=48
	SoundRadius=128.000000
	ReloadAnim="Reload_AR"
	ReloadAnimRate=0.700000
	CockAnimRate=0.950000
	bRapidFire=True
	RelativeRotation=(Pitch=32768)
	DrawScale=0.350000
}
