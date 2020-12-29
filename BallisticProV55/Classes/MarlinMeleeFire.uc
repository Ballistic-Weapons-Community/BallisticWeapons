//=============================================================================
// MarlinSecondaryFire.
//
// Melee attack for Deermaster.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MarlinMeleeFire extends BallisticMeleeFire;

defaultproperties
{
     SwipePoints(0)=(offset=(Pitch=2048,Yaw=2048))
     SwipePoints(1)=(Weight=1,offset=(Pitch=1000,Yaw=1000))
     SwipePoints(2)=(Weight=2)
     SwipePoints(3)=(Weight=1,offset=(Pitch=-1000,Yaw=-1000))
     SwipePoints(4)=(Weight=3,offset=(Pitch=-2048,Yaw=-2048))
     Damage=80.000000
     
     
     DamageType=Class'BallisticProV55.DTMarlinMelee'
     DamageTypeHead=Class'BallisticProV55.DTMarlinMeleeHead'
     DamageTypeArm=Class'BallisticProV55.DTMarlinMelee'
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Marlin.Mar-Melee',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepSwipe"
     FireAnim="Swipe"
     PreFireAnimRate=1.500000
     FireAnimRate=1.500000
     TweenTime=0.000000
     AmmoClass=Class'BallisticProV55.Ammo_Marlin'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}
