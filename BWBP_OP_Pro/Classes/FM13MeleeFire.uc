//=============================================================================
// FM13SecondaryFire.
//
// Melee attack for shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FM13MeleeFire extends BallisticMeleeFire;

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
     
     
     DamageType=Class'BWBP_OP_Pro.DT_FM13Hit'
     DamageTypeHead=Class'BWBP_OP_Pro.DT_FM13HitHead'
     DamageTypeArm=Class'BWBP_OP_Pro.DT_FM13Hit'
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=32.000000,bAtten=True)
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
