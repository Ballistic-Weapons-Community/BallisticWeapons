//=============================================================================
// CX61 third.
//
// by Azarael
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//=============================================================================
class CX61Attachment extends BallisticAttachment;

var	RX22ASpray		Flame;
var	CX61GasSpray		GasSpray;
var 	byte					FlameCount, FlameCountOld, SprayCount, SprayCountOld;
var 	CX61FireHit 		FlameHitFX;
struct SingeSpot
{
	var vector	Loc;			// The spot
	var float	Time;			// Time of hit
};
var   array<SingeSpot> SingeSpots;	// To prevent many decals on the same spot (they're pretty expensive!)

var BUtil.FullSound AltFlyBySound;

replication
{
	reliable if (Role==ROLE_Authority && bNetDirty)
		FlameCount, SprayCount;
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
	
	if(SprayCount != SprayCountOld)
	{
		SprayCountOld = SprayCount;
		GasEffects();
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
	/*
	else
	{
		if (Flame == None)
			Flame = Spawn(class'RX22ASpray',Instigator,,GetModeTipLocation(), rotator(mHitLocation - GetModeTipLocation()));
		if (Instigator.IsFirstPerson())
			Flame.bHidden = true;
		else
		{
			Flame.bHidden = false;
			Flame.SetLocation(GetModeTipLocation());
			Flame.SetRotation(Rotator(mHitLocation - Flame.Location));
		}
		
		Flame.SetFlameRange(VSize(mHitLocation - Flame.Location));
		if (CX61AssaultRifle(Instigator.Weapon) != None)
			CX61AssaultRifle(Instigator.Weapon).Flame = Flame;
		FlyByEffects(Mode, mHitLocation);
	}
	*/
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
	if (GasSpray != None)
	{
		GasSpray.Kill();
		GasSpray.bHidden = false;
		GasSpray = None;
	}
	if (Instigator != None && CX61AssaultRifle(Instigator.Weapon) != None)
		Instigator.Weapon.AmbientSound = None;
}

simulated event Destroyed()
{
	if (Flame != None)
		Flame.Kill();
	if (GasSpray != None)
		GasSpray.Kill();
		
	super.Destroyed();
}

function CX61UpdateFlameHit(Actor HitActor, vector HitLocation, vector HitNormal)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FlameCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	FlameFireEffects();
}

function CX61UpdateGasHit(vector HitLocation)
{
	SprayCount++;
	mHitLocation = HitLocation;
	NetUpdateTime = Level.TimeSeconds - 1;
	GasEffects();
}

simulated function GasEffects()
{
    if ( Level.NetMode == NM_DedicatedServer || Instigator == None)
    	return;

	//Weapon light
	FlashWeaponLight(0);
	//Play pawn anims
	PlayPawnFiring(0);

	if (MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);

	if (GasSpray == None)
		GasSpray = Spawn(class'CX61GasSpray',Instigator,,GetModeTipLocation(), rotator(mHitLocation - GetModeTipLocation()));
		
	if (!Instigator.IsFirstPerson())
	{
		GasSpray.bHidden = false;
		GasSpray.SetLocation(GetModeTipLocation());
		GasSpray.SetRotation(Rotator(mHitLocation - GasSpray.Location));
	}
	GasSpray.SetFlameRange(VSize(mHitLocation - GasSpray.Location));
	if (CX61AssaultRifle(Instigator.Weapon) != None)
		CX61AssaultRifle(Instigator.Weapon).GasSpray = GasSpray;
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
	
	if (CX61AssaultRifle(Instigator.Weapon) != None)
		CX61AssaultRifle(Instigator.Weapon).Flame = Flame;
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
			FlameHitFX = Spawn(class'CX61FireHit',,,mHitLocation, rotator(mHitNormal));
		
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
			class'IM_RX22AScorch'.static.StartSpawn(mHitLocation, mHitNormal, 0, self, HitDelay);
		}
	}
}

defaultproperties
{
     AltFlyBySound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-FlyBy',Volume=0.700000)
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TrackAnimMode=MU_Secondary
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.CX61_TPm'
     RelativeLocation=(X=-2.000000,Y=-2.000000,Z=8.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
