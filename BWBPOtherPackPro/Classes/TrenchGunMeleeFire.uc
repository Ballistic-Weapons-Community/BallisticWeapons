//=============================================================================
// CoachGunSecondaryFire.
//
// Melee attack for coach gun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class TrenchGunMeleeFire extends BallisticMeleeFire;

defaultproperties
{
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     SwipePoints(6)=(offset=(Pitch=-3000))
     WallHitPoint=4
     Damage=50.000000
     DamageType=Class'BWBPOtherPackPro.DT_TrenchMelee'
     DamageTypeHead=Class'BWBPOtherPackPro.DT_TrenchMeleeHead'
     DamageTypeArm=Class'BWBPOtherPackPro.DT_TrenchMelee'
     KickForce=2000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.Marlin.Mar-Melee',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepWrench"
     FireAnim="Wrench"
     PreFireAnimRate=2.000000
     FireAnimRate=1.600000
     TweenTime=0.000000
     FireRate=0.700000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_TrenchgunShells'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}
