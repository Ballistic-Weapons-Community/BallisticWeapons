//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_PrimaryFire extends BallisticInstantFire;

var   Actor		Ignition;
var   Actor		MuzzleFlame;
var   Actor		Heater;
var   bool		bIgnited;
var() sound		FireSoundLoop;
var() sound		XR4FireSound;
var() sound		BotFireSound;
/*
simulated function SwitchCannonMode (byte NewMode)
{
	if (NewMode == 1)
	{
		BallisticFireSound.Sound=XR4FireSound;
		TraceRange.Max=12000;
		TraceRange.Min=10000;
     	RangeAtten=0.650000;
     	WaterRangeAtten=0.800000;
     	FireChaos=0.05;
     	XInaccuracy=2;
     	YInaccuracy=2;
		Damage = 35;
		DamageHead = 85;
		DamageLimb = 20;

     	ShakeRotMag.X=128;
		ShakeRotMag.Y=64;
		ShakeRotRate.X=10000;
		ShakeRotRate.Y=10000;
		ShakeRotRate.Z=10000;
     	ShakeRotTime=2.000000;
     	ShakeOffsetMag.X=-30.000000;
     	ShakeOffsetRate.X=-1000.000000;
     	ShakeOffsetTime=2.000000;
	}
	else
	{
		FireRate=default.FireRate;
//		AmmoPerFire=Default.AmmoPerFire;
		RangeAtten=Default.RangeAtten;
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		FireAnim=default.FireAnim;
    	 KickForce=Default.KickForce;
		RecoilPerShot=Default.RecoilPerShot;
     	FireChaos=Default.FireChaos;

		Damage = default.Damage;
		DamageHead = default.DamageHead;
		DamageLimb = default.DamageLimb;

     	ShakeRotMag.X=64;
		ShakeRotMag.Y=32;
		ShakeRotRate.X=5000;
		ShakeRotRate.Y=5000;
		ShakeRotRate.Z=5000;
     	ShakeRotTime=1.000000;
     	ShakeOffsetMag.X=-15.000000;
     	ShakeOffsetRate.X=-500.000000;
     	ShakeOffsetTime=1.000000;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

	Load=AmmoPerFire;
}
*/

function StartBerserk()
{
 	FireRate = 0.03;
    FireAnimRate = default.FireAnimRate/0.75;
    ReloadAnimRate = default.ReloadAnimRate/0.75;
}

function StopBerserk()
{
    FireRate = default.FireRate;
    FireAnimRate = default.FireAnimRate;
    ReloadAnimRate = default.ReloadAnimRate;
}

function StartSuperBerserk()
{
    FireRate = 0.03;
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
}


function float MaxRange()	{	return 6400;	}

function Supercharger_ChargeControl GetChargeControl()
{
	return Supercharger_AssaultWeapon(Weapon).GetChargeControl();
}

function DoFireEffect()
{
    local Vector Start, Dir, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local float Dist;
	local int i;

    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);

	DoTrace(Start, Aim);

    Dir = Vector(Aim);
	End = Start + (Dir*MaxRange());
	Weapon.bTraceWater=true;
	for (i=0;i<20;i++)
	{
		Other = Trace(HitLocation, HitNormal, End, Start, true);
		if (Other == None || Other.bWorldGeometry || Mover(Other) != none || Vehicle(Other)!=None || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
			break;
		Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
	}
	Weapon.bTraceWater=false;

	if (Other == None)
		HitLocation = End;
	if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		Other = None;

	Dist = VSize(HitLocation-Start);


	if (Supercharger_AssaultWeapon(Weapon).CurrentWeaponMode == 2)
	{
		if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
			GetChargeControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other, 1);
		else
			GetChargeControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None, 1);
	}
	SendFireEffect(Other, HitLocation, HitNormal, 0);

	Super(BallisticFire).DoFireEffect();
}

/* Why did I have this here? 
// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				break;
			}
			LastHitLoc = HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				DoDamage(Other, HitLocation, InitialStart, X, PenCount, WallCount, WaterHitLoc);
				LastOther = Other;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
				End = Start + X * Dist;
				Weapon.bTraceWater=true;
				continue;
			}
			break;
		}
		else
		{
			LastHitLoc = End;
			break;
		}
	}
}*/

//Do the spread on the client side
function PlayFiring()
{
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	if (Supercharger_AssaultWeapon(Weapon).CurrentWeaponMode == 1)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	else if ( AIController(Instigator.Controller) != None)
	{
		Weapon.PlayOwnedSound(BotFireSound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	else
	{
		if (FireSoundLoop != None)
			Instigator.AmbientSound = FireSoundLoop;

		if (!bIgnited)
		{
			BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		}
		if (MuzzleFlame == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlame, class'HVCMk9MuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip');
	}
}

function ServerPlayFiring()
{
	if (!bIgnited)
	{
		bIgnited = true;
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
}

simulated function bool AllowFire()
{
	if (!super.AllowFire() || Instigator.HeadVolume.bWaterVolume)
	{
		if (bIgnited)
			StopFiring();
		return false;
	}
	return true;
}

function StopFiring()
{
	bIgnited = false;
	Instigator.AmbientSound = None;
	if (MuzzleFlame != None)
	{
		Emitter(MuzzleFlame).Kill();
		MuzzleFlame = None;
	}
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();
	if (MuzzleFlame != None)
		MuzzleFlame.Destroy();
}



defaultproperties
{
     aimerror=900.000000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     AmmoPerFire=1
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireEnd',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
     bCockAfterEmpty=True
     BotFireSound=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireSingle'
     bPawnRapidFireAnim=True
     bPenetrate=False
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-FireStart2',Volume=1.000000,Radius=48.000000,bAtten=True)
//     Damage=1
//     DamageHead=2
//     DamageLimb=1
     DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifle'
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-OverHeat',Volume=1.000000)
//     FireChaos=0.010000
	 FireAnim=""
     FireEndAnim=
//     FireRate=0.0631500
     FireSoundLoop=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireLoop'
     FlashBone="Muzzle"
     FlashScaleFactor=0.250000
     KickForce=20000
     MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
     PenetrateForce=180
     PreFireAnim=
//     RangeAtten=0.950000
//     RecoilPerShot=130.000000
     RunningSpeedThresh=1000.000000
     ShakeOffsetMag=(X=-15.000000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     TraceRange=(Min=6400.000000,Max=6400.000000)
     TweenTime=0.000000
     WarnTargetPct=0.200000
//     WaterRangeAtten=0.100000
//     WaterRangeFactor=0.800000
     XInaccuracy=32.000000
     XR4FireSound=Sound'BWBP_SKC_Sounds.Misc.LS14-CarbineFire'
     YInaccuracy=32.000000
//     Damage=(Min=15.000000,Max=15.000000)
//     DamageHead=(Min=20.000000,Max=20.000000)
//     DamageLimb=(Min=10.000000,Max=10.000000)
}
