class CYLOFirestormMeleeFire extends BallisticMeleeFire;

defaultproperties
{
     SwipePoints(0)=(offset=(Pitch=2048,Yaw=2048))
     SwipePoints(1)=(Weight=1,offset=(Pitch=1000,Yaw=1000))
     SwipePoints(2)=(Weight=2)
     SwipePoints(3)=(Weight=1,offset=(Pitch=-1000,Yaw=-1000))
     SwipePoints(4)=(Weight=3,offset=(Pitch=-2048,Yaw=-2048))
     
     
     DamageType=Class'BWBPRecolorsPro.DTCYLOFirestormStab'
     DamageTypeHead=Class'BWBPRecolorsPro.DTCYLOFirestormStabHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTCYLOFirestormStab'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BallisticSounds3.A73.A73Stab',Volume=0.5,Radius=32.000000,Pitch=1.250000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepMelee1"
     FireAnim="Melee1"
     TweenTime=0.000000
     FireRate=0.500000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_CYLOInc'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.050000
}
