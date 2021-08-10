//It's XMV850MinigunAttachment
class Z250Attachment extends BallisticAttachment;

var float	LastShotTime;

var byte	YawSpeed;
var byte	PitchSpeed;

var() class<BallisticInstantFire>	FireClass;

var byte	NetBarrelSpeed;
var int		BarrelTurn;
var float	BarrelSpeed;
var float	LastMinigunFlashTime;
var float	LastMinigunAltFlashTime;

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		YawSpeed, PitchSpeed;
	unreliable if (Role == ROLE_Authority)
		NetBarrelSpeed;
}

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (LastMinigunFlashTime != Level.TimeSeconds)
	{
		LastMinigunFlashTime = Level.TimeSeconds;
		Mode=0;
	}
	else if (LastMinigunAltFlashTime != Level.TimeSeconds)
	{
		LastMinigunAltFlashTime = Level.TimeSeconds;
		Mode = 1;
	}
	else
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{
			if (BallisticTurret(Instigator) != None)
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*1.666, Instigator, AltFlashBone);
			else
				class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		}
		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
		{
			if (BallisticTurret(Instigator) != None)
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*1.666, Instigator, FlashBone);
			else
				class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		}
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

simulated event Tick(float DT)
{
	local rotator BT;

	super.Tick(DT);

	if (Role == Role_Authority)
		NetBarrelSpeed = BarrelSpeed * 255;
	else
		BarrelSpeed = float(NetBarrelSpeed) / 255.0;

	if (level.NetMode != NM_DedicatedServer)
	{
		BarrelTurn += BarrelSpeed * 655360 * DT;
		BT.Roll = BarrelTurn;
		SetBoneRotation('BarrelArray', BT);
	}
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (FireCount != OldFireCount)
	{
		if (FireCount < OldFireCount)
			MinigunEffects((FireCount + 256) - OldFireCount);
		else
			MinigunEffects(FireCount - OldFireCount);
		FiringMode = 0;
		OldFireCount = FireCount;
		LastShotTime = level.TimeSeconds;
	}
	else
		super.PostNetReceive();
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
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, true,, HitMat); //needs to pick up pawns to spawn explosion fx
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
	if (mHitActor == None)
		return;
	if (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && mHitActor.bProjTarget)
	{
		Spawn (class'IE_IncBulletMetal', ,, HitLocation,);
		return;
	}
	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}


simulated function MinigunEffects (int ShotCount)
{
	local int i;
	local rotator RotSpeed, AimRef, AimDir, AimInterval;
	local float DT;

	RotSpeed.Yaw = -16384 + 129 * YawSpeed;
	RotSpeed.Pitch = -16384 + 129 * PitchSpeed;

	InstantFireEffects(FiringMode);
	FlashMuzzleFlash (FiringMode);
	FlashWeaponLight(FiringMode);
	PlayPawnFiring(FiringMode);
	EjectBrass(FiringMode);

	if (ShotCount > 1)
	{
		if (level.TimeSeconds - LastShotTime < 0.2)
			DT = level.TimeSeconds - LastShotTime;
		else
			DT = 0.1;
		AimInterval = RotSpeed * DT;
		if (Instigator!=None)
			AimRef = rotator(mHitLocation - Instigator.Location + Instigator.EyePosition());
		else
			AimRef = rotator(mHitLocation - Location);
		for (i=1;i<ShotCount;i++)
		{
			//Eject Brass
			EjectBrass(FiringMode);

			AimDir = AimRef - AimInterval * i;
			AimDir.Yaw += FireClass.default.XInaccuracy * 2 * FRand() - FireClass.default.XInaccuracy;
			AimDir.Pitch += FireClass.default.YInaccuracy * 2 * FRand() - FireClass.default.YInaccuracy;
			MinigunShotEffects(AimDir, FiringMode);
		}
	}
}

simulated function MinigunShotEffects(rotator Aim, byte Mode)
{
	local Vector HitLoc, HitNorm, Start, End, X;
	local actor T;
	local Material HitMat;
	local int HitSurf;

	X = Vector(Aim);
	if (Instigator!=None)
		Start = Instigator.Location + Instigator.EyePosition();
	else
		Start = Location;
	End = Start + X * Lerp(FRand(), FireClass.default.TraceRange.Min, FireClass.default.TraceRange.Max);
	T = Trace(HitLoc, HitNorm, End, Start, true,,HitMat);
	if (T == None)
	{
		DoWaterTrace(Mode, Start, End);
		SpawnTracer(Mode, End);
	}
	else
	{
		DoWaterTrace(Mode, Start, HitLoc);
		SpawnTracer(Mode, HitLoc);
	}
	if (!T.bWorldGeometry && Mover(T) == None && T.bProjTarget)
	{
		Spawn (class'IE_IncBulletMetal', ,, HitLoc,);
		return;
	}
	if (T == None || (!T.bWorldGeometry && Mover(T) == None))
		return;
	if (HitMat == None)
		HitSurf = int(T.SurfaceType);
	else
		HitSurf = int(HitMat.SurfaceType);
	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLoc, HitNorm, HitSurf, self);
}

function UpdateTurnVelocity(rotator TurnVelocity)
{
	YawSpeed = Clamp(TurnVelocity.Yaw + 16384, 0, 32768) / 128.5;
	PitchSpeed = Clamp(TurnVelocity.Pitch + 16384, 0, 32768) / 128.5;
}

// Play flyby sound effects
simulated function FlyByEffects(byte Mode, Vector HitLoc)
{
	local Vector TipLoc, ViewLoc, PointX, Dir;
	local float DotResult, XDist;

	if (Level.DetailMode < DM_High || !class'BallisticMod'.default.bBulletFlybys || FRand() > 0.3)
		return;
	if (FlyByMode == MU_None || (FlyByMode == MU_Secondary && Mode == 0) || (FlyByMode == MU_Primary && Mode != 0))
		return;

	TipLoc = GetModeTipLocation();
	ViewLoc = level.GetLocalPlayerController().ViewTarget.Location;
	Dir = Normal(HitLoc-TipLoc);
	// >>> Find PointX which will be the point closest to ViewLoc on the traceline
	DotResult = Dir Dot Normal(ViewLoc-TipLoc);
	if (DotResult < 0)
		return;	// No sound effect if view is back behind where the line starts!
	XDist = DotResult * VSize(ViewLoc-TipLoc);
	PointX = TipLoc + Dir * XDist;
	// <<<
	if (VSize(PointX-ViewLoc) > FlybyRange)
		return;	// View too far from line
	if (XDist < 256 || XDist > VSize(HitLoc-TipLoc) - 128)
		return;	// PointX is not actually on the line!

	FlyBySound.Pitch = 0.85 + 0.3 * FRand();
	class'BCFlyByActor'.static.SoundOff(self, FlyBySound, PointX, XDist/FlyByBulletSpeed);
}

// Return location of brass ejector
simulated function Vector GetEjectorLocation(optional out Rotator EjectorAngle)
{
    local Coords C;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords(BrassBone);
	else if (BallisticTurret(Instigator) != None)
		C = Instigator.GetBoneCoords(BrassBone);
	else
		C = GetBoneCoords(BrassBone);
	if (Instigator != None && VSize(C.Origin - Instigator.Location) > 200)
	{
		EjectorAngle = Instigator.Rotation;
		return Instigator.Location;
	}
	if (BallisticTurret(Instigator) != None)
		EjectorAngle = Instigator.GetBoneRotation(BrassBone);
	else
		EjectorAngle = GetBoneRotation(BrassBone);
    return C.Origin;
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return Instigator.Weapon.GetEffectStart();
		
	return GetBoneCoords('tip').Origin;
}

defaultproperties
{
     FireClass=Class'BWBP_OP_Pro.Z250PrimaryFire'
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_MinigunBullet'
     BrassClass=Class'BallisticProV55.Brass_Minigun'
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Incendiary'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_MG"
     ReloadAnimRate=1.500000
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.Z250_TPm'
     RelativeLocation=(X=3.000000,Z=8.000000)
     DrawScale=0.350000
}
