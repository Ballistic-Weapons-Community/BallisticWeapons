//=============================================================================
// XMV850MinigunAttachment.
//
// 3rd person weapon attachment for XMV850 Minigun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XMV850MinigunAttachment extends BallisticAttachment;

var float	LastShotTime;

var byte	YawSpeed;
var byte	PitchSpeed;

var() class<BallisticInstantFire>	FireClass;

var XMV850Pack 	Pack;

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

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( Pack != None )
		Pack.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack!= None)
		Pack.bHidden = NewbHidden;
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
		if (BallisticTurret(Instigator) != None)
		{
			if (Pack == None && BallisticTurret(Instigator).Driver != None)
				SpawnPack();
			else if (Pack != None && BallisticTurret(Instigator).Driver == None)
				Pack.Destroy();
		}
		// FIXME: Revive this... and make belts connect
//		TestBoneMove();
		// Make 3rd person mesh spin barrels
		BarrelTurn += BarrelSpeed * 655360 * DT;
		BT.Roll = BarrelTurn;
		if (XMV850Turret(Instigator) != None)
			Instigator.SetBoneRotation('Barrels', BT);
		else
			SetBoneRotation('Barrels', BT);
	}
}

simulated function TestBoneMove()
{
	local vector NewLoc;

	SetBoneDirection('Stock', rot(0,0,0), vect(0,0,0), 1.0, 0);
	NewLoc = Instigator.Location - GetBoneCoords('Stock').Origin;
	SetBoneDirection('Stock', rot(0,0,0), NewLoc, 1.0, 0);
}

simulated function SpawnPack()
{
	if (Pack == None)
		Pack = Spawn(class'XMV850Pack');
	if (Pack != None)
	{
		if (BallisticTurret(Instigator) != None)
		{
			if (BallisticTurret(Instigator).Driver != None)
				BallisticTurret(Instigator).Driver.AttachToBone(Pack,'Spine');
		}
		else if (Instigator != None)
			Instigator.AttachToBone(Pack,'Spine');
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
	T = Trace(HitLoc, HitNorm, End, Start, false,,HitMat);
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

simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();
	super.Destroyed();
}

simulated Event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BallisticTurret(Instigator) != None)
		bHidden=true;
	SpawnPack();
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return Instigator.Weapon.GetEffectStart();
	
	if (BallisticTurret(Instigator) != None)
		return Instigator.GetBoneCoords('tip').Origin;
		
	return GetBoneCoords('tip').Origin;
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

defaultproperties
{
	 WeaponClass=class'XMV850Minigun'
     FireClass=class'XMV850MinigunPrimaryFire'
     MuzzleFlashClass=class'XMV850FlashEmitter'
     AltMuzzleFlashClass=class'XMV850FlashEmitter'
	 FlashScale=0.600000
     ImpactManager=class'IM_MinigunBullet'
     BrassClass=class'Brass_Minigun'
     TracerClass=class'TraceEmitter_Default'
     TracerChance=0.800000
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_MG"
     ReloadAnimRate=1.375000
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.XMV850_TPm'
     DrawScale=0.300000
}
