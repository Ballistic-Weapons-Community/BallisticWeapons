//=============================================================================
// GASCSecondaryFire.
//
// Hold fire to draw back the weapon and release to slash out at your opponent.
// Good for sneaking up on enemies.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class GASCMeleeFire extends BallisticMeleeFire;

simulated function bool HasAmmo()
{
	return true;
}

function PlayPreFire()
{
	super.PlayPreFire();

	GASCPistol(Weapon).bStriking = true;
}

function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		FireAnim = 'MeleeStabOpen';
		PreFireAnim = 'MeleePrepOpen';
	}
	else
	{
		FireAnim = 'MeleeStab';
		PreFireAnim = 'MeleePrep';
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
     Damage=90.000000
     DamageType=Class'BWBP_APC_Pro.DTGASCMelee'
     DamageTypeHead=Class'BWBP_APC_Pro.DTGASCMelee'
     DamageTypeArm=Class'BWBP_APC_Pro.DTGASCMelee'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.X4.X4_Melee',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="MeleePrep"
     FireAnim="MeleeStab"
     FireRate=0.450000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_GASCClip'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
