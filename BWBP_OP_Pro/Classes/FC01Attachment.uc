//=============================================================================
// FC01Attachment.
//
// 3rd person weapon attachment for the FC01
// has a laser that tracks tagged targets
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FC01Attachment extends BallisticAttachment;

var int PhotonFireCount, OldPhotonFireCount;
var() class<BCTraceEmitter>		PhotonTracerClass;
var() class<BCImpactManager>	PhotonImpactManager;
var() actor						PhotonMuzzleFlash;
var() class<Actor>              PhotonMuzzleFlashClass;

var   bool			bLaserOn;		//Is laser currently active
var   bool			bOldLaserOn;	//Old bLaserOn
var   LaserActor	Laser;			//The laser actor
var   vector		LaserEndLoc;
var   Emitter		LaserDot;


replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn,PhotonFireCount;
	unreliable if ( Role==ROLE_Authority && !bNetOwner )
		LaserEndLoc;
}

//Laser
simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
	laserDot.bHidden=false;
}

simulated function Tick(float DT)
{
	local Vector Scale3D, Loc;

	Super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'LaserActor_G5Painter',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		KillLaserDot();
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
		SpawnLaserDot();
	}

	if (LaserDot != None)
		LaserDot.SetLocation(LaserEndLoc);

	Loc = GetModeTipLocation();

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(LaserEndLoc - Loc));
//	Laser.SetRelativeRotation(Rotator(HitLocation - Loc) - GetBoneRotation('tip'));
	Scale3D.X = VSize(LaserEndLoc-Laser.Location)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
}

simulated function Destroyed()
{
	if (LaserDot != None)
		LaserDot.Destroy();
	if (Laser != None)
		Laser.Destroy();
	Super.Destroyed();
}

//photon

function PhotonUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsAlt, optional vector WaterHitLoc)
{
	mHitSurf = HitSurf;
	WaterHitLocation = WaterHitLoc;
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 2;
	PhotonFireCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonEffects();
}

// If firecount changes, start ThirdPersonEffects()
simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (DirectImpactCount != OldDirectImpactCount)
	{
		DoDirectHit(0, DirectImpact.HitLoc, class'BUtil'.static.ByteToNorm(DirectImpact.HitNorm), DirectImpact.HitSurf);
		OldDirectImpactCount = DirectImpactCount;
	}
	if (FireCount != OldFireCount)
	{
		FiringMode = 0;
		ThirdPersonEffects();
		OldFireCount = FireCount;
	}
	if (AltFireCount != OldAltFireCount)
	{
		FiringMode = 1;
		ThirdPersonEffects();
		OldAltFireCount = AltFireCount;
	}
	if (PhotonFireCount != OldPhotonFireCount)
	{
		FiringMode = 2;
		ThirdPersonEffects();
		OldPhotonFireCount = PhotonFireCount;
	}
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

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
	if (ImpactManager != None)
	{
		if (FiringMode == 2)
			PhotonImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
		else 
			ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	}
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (class'BallisticMod'.default.EffectsDetailMode == 0)
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
	if (TracerClass != None && bThisShot && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
		{
			if (FiringMode == 2)
				Tracer = Spawn(PhotonTracerClass, self, , TipLoc, Rotator(V - TipLoc));
			else 
				Tracer = Spawn(TracerClass, self, , TipLoc, Rotator(V - TipLoc));
		}
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

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)	
		return Instigator.Weapon.GetEffectStart();

	if (FiringMode == 2)
		return GetBoneCoords('tipalt').Origin;
	
	return GetBoneCoords('tip').Origin;
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

	if (PhotonMuzzleFlashClass != None && FiringMode == 2)
	{
		if (PhotonMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (PhotonMuzzleFlash, PhotonMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		PhotonMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (MuzzleFlashClass != None && FiringMode == 0)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

defaultproperties
{
	 WeaponClass=class'FC01SmartGun'
	 PhotonTracerClass=Class'BWBP_OP_Pro.TraceEmitter_FC01Photon'
     PhotonImpactManager=Class'BWBP_OP_Pro.IM_FC01Photon'
	 PhotonMuzzleFlashClass=Class'BWBP_OP_Pro.FC01PhotonFlashEmitter'
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
	 FlashScale=0.275000
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="tipalt"
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassMode=MU_Secondary
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.FC01_TPm'
	 RelativeRotation=(Pitch=32768)
	 RelativeLocation=(Z=10)
     DrawScale=0.900000
}