class DragonsToothStabFire extends BallisticMeleeFire;

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(0)=(offset=(Yaw=768))
     SwipePoints(1)=(offset=(Yaw=0))
     SwipePoints(2)=(offset=(Yaw=-768))
     WallHitPoint=0
     NumSwipePoints=3
     FatiguePerStrike=0.1
     bCanBackstab=True
     bNoPositionalDamage=False
     TraceRange=(Min=190.000000,Max=190.000000)
     Damage=100.000000
     DamageHead=150.000000
	DamageLimb=100.000000
	FireRate=1.5
     DamageType=Class'BWBPRecolorsPro.DT_DTSChest'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_DTSHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_DTSLimb'
     KickForce=100
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=256.000000,bAtten=True)
     bAISilent=True
	FireAnim="Stab"
	FireAnimRate=1
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.800000
}
