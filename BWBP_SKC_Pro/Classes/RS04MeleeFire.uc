//=============================================================================
// RS04MeleeFire.
//
// Hold fire to draw back the weapon and release to slash out at your opponent.
// Good for sneaking up on enemies.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04MeleeFire extends BallisticMeleeFire;


simulated function SwitchBladeMode (bool bLoaded)
{
	if (bLoaded)
	{
		FireAnimRate=0.900000;
		Damage *= 1.5;
		DamageType=Class'BWBP_SKC_Pro.DTRS04Stab';
		DamageTypeHead=Class'BWBP_SKC_Pro.DTRS04Stab';
		DamageTypeArm=Class'BWBP_SKC_Pro.DTRS04Stab';
	}
	else
	{
		PreFireAnim='PrepBash';
		FireAnim='Bash';
		FireAnimRate=default.FireAnimRate;
		Damage=default.Damage;
		DamageType=default.DamageType;
		DamageTypeHead=default.DamageTypeHead;
		DamageTypeArm=default.DamageTypeArm;
	}

	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
}

simulated function bool HasAmmo()
{
	return true;
}

function PlayPreFire()
{
	super.PlayPreFire();

	RS04Pistol(Weapon).bStriking = true;
}

function PlayFiring()
{
	if (BW.MagAmmo == 0)
	{
		PreFireAnim = 'MeleePrepOpen';
		FireAnim = 'MeleeOpen';
	}
	else
	{
		PreFireAnim = 'MeleePrep';
		FireAnim = 'Melee';
	}
	super.PlayFiring();
}

defaultproperties
{
	SwipePoints(0)=(offset=(Pitch=2048,Yaw=2048))
	SwipePoints(1)=(Weight=1,offset=(Pitch=1000,Yaw=1000))
	SwipePoints(2)=(Weight=2)
	SwipePoints(3)=(Weight=1,offset=(Pitch=-1000,Yaw=-1000))
	SwipePoints(4)=(Weight=3,offset=(Pitch=-2048,Yaw=-2048))
	TraceRange=(Min=140.000000,Max=140.000000)
	Damage=35.000000


	DamageType=Class'BWBP_SKC_Pro.DTRS04Bonk'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTRS04Bonk'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTRS04Bonk'
	KickForce=100
	HookStopFactor=1.700000
	HookPullForce=100.000000
	bUseWeaponMag=False
	bReleaseFireOnDie=False
	bIgnoreReload=True
	ScopeDownOn=SDO_PreFire
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Melee',Volume=0.5,Radius=12.000000,bAtten=True)
	bAISilent=True
	bFireOnRelease=True
	PreFireAnim="MeleePrep"
	FireAnim="Melee"
	FireRate=0.450000
	AmmoClass=Class'BallisticProV55.Ammo_45HV'
	AmmoPerFire=0
	ShakeRotMag=(X=64.000000,Y=128.000000)
	ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
	ShakeRotTime=2.500000
	BotRefireRate=0.800000
	WarnTargetPct=0.050000
}
