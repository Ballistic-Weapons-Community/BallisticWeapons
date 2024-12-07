//=============================================================================
// AH104Attachment.
//
// 3rd person weapon attachment for AH104 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AH104Attachment extends BallisticAttachment;

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   BallisticWeapon      Heavy;

var	RX22ASpray		Flame;
var 	byte					FlameCount, FlameCountOld;
var 	AH104FireHit 		FlameHitFX;

struct SingeSpot
{
	var vector	Loc;			// The spot
	var float	Time;			// Time of hit
};
var   array<SingeSpot> SingeSpots;	// To prevent many decals on the same spot (they're pretty expensive!)

var BUtil.FullSound AltFlyBySound;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLaserOn;
	reliable if (Role==ROLE_Authority && bNetDirty)
		FlameCount;
	unreliable if ( Role==ROLE_Authority )
		LaserRot;
}

simulated function Vector GetAltTipLocation()
{
	return GetBoneCoords('tip2').Origin;
}

simulated event PostNetReceive()
{
	if (FlameCount != FlameCountOld)
	{
		FlameCountOld = FlameCount;
		FlameFireEffects();
	}
	
	super.PostNetReceive();
}

//No flash for alt (flame and gas)
simulated function FlashMuzzleFlash(byte Mode)
{
	if (Mode != 0)
		return;

	super.FlashMuzzleFlash(Mode);
}

simulated event Timer()
{
	super.Timer();
	StopSpray();
}

simulated function InstantFireEffects(byte Mode)
{
	if (level.NetMode == NM_DedicatedServer)
		return;

	if (Mode == 0)
		Super.InstantFireEffects(Mode);
}

// Play flyby sound effects
simulated function FlyByEffects(byte Mode, Vector HitLoc)
{
	local Vector TipLoc, ViewLoc, PointX, Dir;
	local float DotResult, XDist;

	if (Level.DetailMode < DM_High || !class'BallisticMod'.default.bBulletFlybys || FlyBySound.Sound == None)
		return;
	if (FlyByMode == MU_None || (FlyByMode == MU_Secondary && Mode == 0) || (FlyByMode == MU_Primary && Mode != 0))
		return;

	TipLoc = GetModeTipLocation();
	if (level.GetLocalPlayerController().ViewTarget != None)
		ViewLoc = level.GetLocalPlayerController().ViewTarget.Location;
	else
		ViewLoc = level.GetLocalPlayerController().Location;

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
	if (Mode == 0)
		class'BCFlyByActor'.static.SoundOff(self, FlyBySound, PointX, XDist/FlyByBulletSpeed);
	else class'BCFlyByActor'.static.SoundOff(self, AltFlyBySound, PointX, XDist/FlyByBulletSpeed);
}

simulated function StopSpray()
{
	if (Flame != None)
	{
		Flame.Kill();
		Flame.bHidden = false;
		Flame = None;
	}
	if (Instigator != None && AH104Pistol(Instigator.Weapon) != None)
		Instigator.Weapon.AmbientSound = None;
}

simulated event Destroyed()
{
	if (Flame != None)
		Flame.Kill();
	if (Laser != None)
		Laser.Destroy();
		
	super.Destroyed();
}

function AH104UpdateFlameHit(Actor HitActor, vector HitLocation, vector HitNormal)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FlameCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	FlameFireEffects();
}

simulated function FlameFireEffects()
{
	local vector Dir;
	local int i;
	local float HitDelay;

    if ( Level.NetMode == NM_DedicatedServer || Instigator == None)
    	return;

	//Weapon light
	FlashWeaponLight(0);
	//Play pawn anims
	PlayPawnFiring(0);

	if (MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);

	if (Flame == None)
		Flame = Spawn(class'RX22ASpray',Instigator,,GetModeTipLocation(), rotator(mHitLocation - GetModeTipLocation()));
		
	if (Instigator.IsFirstPerson())
	{}
//		Flame.bHidden = true;
	else
	{
		Flame.bHidden = false;
		Flame.SetLocation(GetModeTipLocation());
		Flame.SetRotation(Rotator(mHitLocation - Flame.Location));
	}
	
	Flame.SetFlameRange(VSize(mHitLocation - Flame.Location));
	
	if (AH104Pistol(Instigator.Weapon) != None)
		AH104Pistol(Instigator.Weapon).Flame = Flame;
	FlyByEffects(0, mHitLocation);
	
	if (level.NetMode == NM_Client)
	{
		Dir = Normal(mHitLocation - Instigator.Location);
		mHitActor = Trace(mHitLocation, mHitNormal, mHitLocation + Dir * 10, mHitLocation - Dir * 10, false);
	}
	
	if (mHitActor != None)
	{
		HitDelay = VSize(Instigator.Location - mHitLocation) / 1400;
		if (FlameHitFX == None || FlameHitFX.bLost)
			FlameHitFX = Spawn(class'AH104FireHit',,,mHitLocation, rotator(mHitNormal));
		
		if (FlameHitFX != None)
			FlameHitFX.AddHit(mHitLocation, mHitNormal, level.TimeSeconds + HitDelay);

		for(i=0;i<SingeSpots.length;i++)
			if (SingeSpots[i].Time < level.TimeSeconds - 10)
			{
				SingeSpots.Remove(i,1);
				i--;
			}
			else if (VSize(SingeSpots[i].Loc-mHitLocation) < 128)
				break;
		if (i>=SingeSpots.length)
		{
			i = SingeSpots.length;
			SingeSpots.length = i + 1;
			SingeSpots[i].Loc = mHitLocation;
			SingeSpots[i].Time = level.TimeSeconds;
			class'IM_AH104Scorch'.static.StartSpawn(mHitLocation, mHitNormal, 0, self, HitDelay);
		}
	}
}

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && Heavy != None)
	{
		LaserRot = Instigator.GetViewRotation();
		LaserRot += Heavy.GetAimPivot();
		LaserRot += Heavy.GetRecoilPivot();
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

	Loc = GetModeTipLocation();

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

function InitFor(Inventory I)
{
   Super.InitFor(I);

   if (BallisticWeapon(I) != None)
	  Heavy = BallisticWeapon(I);
}


defaultproperties
{
	WeaponClass=class'AH104Pistol'
	 MuzzleFlashClass=Class'BWBP_SKC_Pro.AH104FlashEmitter'
	 //AltMuzzleFlashClass=Class'BWBP_SKC_Pro.AH104FlashEmitter'
     FlashScale=0.050000	 
     AltFlyBySound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-FlyBy',Volume=0.700000)
     ImpactManager=Class'BWBP_SKC_Pro.IM_ExpBullet'
     AltFlashBone="ejector"
     BrassClass=class'Brass_Pistol'
     FlashMode=MU_Both
     TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_HMG'
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlyBy',Volume=1.500000)
	 ReloadAnimRate=0.800000
	 CockAnimRate=0.800000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.AH104_TPm'
     DrawScale=1.000000
}
