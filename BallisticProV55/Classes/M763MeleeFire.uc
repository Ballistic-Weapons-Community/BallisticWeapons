//=============================================================================
// M763SecondaryFire.
//
// Melee attack for shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M763MeleeFire extends BallisticMeleeFire;

defaultproperties
{
     SwipePoints(0)=(Weight=1,offset=(Yaw=5120))
     SwipePoints(1)=(Weight=2,offset=(Yaw=3840))
     SwipePoints(2)=(Weight=3,offset=(Yaw=2560))
     SwipePoints(3)=(Weight=4,offset=(Yaw=1280))
     SwipePoints(4)=(Weight=5)
     SwipePoints(5)=(Weight=4,offset=(Yaw=-1280))
     SwipePoints(6)=(Weight=3,offset=(Yaw=-2560))
     SwipePoints(7)=(Weight=2,offset=(Yaw=-3840))
     SwipePoints(8)=(Weight=1,offset=(Yaw=-5120))
     DamageHead=35.000000
     DamageLimb=35.000000
     DamageType=Class'BallisticProV55.DTM763Hit'
     DamageTypeHead=Class'BallisticProV55.DTM763HitHead'
     DamageTypeArm=Class'BallisticProV55.DTM763Hit'
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=256.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepMelee"
     FireAnim="Melee"
     TweenTime=0.000000
     AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}
