//=============================================================================
// A73 Melee Fire.
//
// Bayonette melee attack for the A2W
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A2WMeleeFire extends BallisticMeleeFire;

defaultproperties
{
     
     DamageType=Class'BallisticProV55.DTA73Stab'
     DamageTypeHead=Class'BallisticProV55.DTA73StabHead'
     DamageTypeArm=Class'BallisticProV55.DTA73Stab'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Stab',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="MeleePrep"
     FireAnim="MeleeFire"
     TweenTime=0.000000
     FireRate=0.600000
     AmmoClass=Class'BallisticProV55.Ammo_Cells'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.050000
}
