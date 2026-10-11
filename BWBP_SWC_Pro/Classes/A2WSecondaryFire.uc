//=============================================================================
// FP7PrimaryFire.
//
// FP7 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A2WSecondaryFire extends BallisticHandGrenadeFire;

// The lance is thrown with a hand grenade's wind up and release, but it is no grenade: what that fire class asks a
// grenade for (pin, clip, fuse and smoke) is left out here. It asked the lance all the same and logged a dozen
// warnings for every throw

function PlayPreFire()
{
	Weapon.PlayAnim(PreFireAnim, PreFireAnimRate, TweenTime);
}

function FlashMuzzleFlash();

simulated function bool AllowFire()
{
	return Super(WeaponFire).AllowFire();
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	Super(BallisticProjectileFire).ModeDoFire();
}

function float CalculateDetonateDelay(float DetonateDelay)
{
	return DetonateDelay;
}

defaultproperties
{
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassBone="tip"
     BrassOffset=(X=-20.000000,Z=-2.000000)
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=32.000000,batten=false)
     PreFireAnim="ThrowPrep"
     FireAnim="Throw"
     AmmoClass=Class'BWBP_OP_Pro.Ammo_L8GI'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_SWC_Pro.A2WThrownProjectile'
}
