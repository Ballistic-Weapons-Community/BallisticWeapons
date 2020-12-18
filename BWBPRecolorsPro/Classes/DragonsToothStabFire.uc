class DragonsToothStabFire extends BallisticMeleeFire;

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(0)=(offset=(Yaw=1024))
     SwipePoints(1)=(offset=(Yaw=512))
     SwipePoints(2)=(offset=(Yaw=0))
     SwipePoints(3)=(offset=(Yaw=-512))
     SwipePoints(4)=(offset=(Yaw=-1024))
     WallHitPoint=2
     NumSwipePoints=5
     FatiguePerStrike=0.1
     bCanBackstab=True
     TraceRange=(Min=200.000000,Max=200.000000)
     Damage=135.000000
     
	
	 FireRate=1.5
     DamageType=Class'BWBPRecolorsPro.DT_DTSStabChest'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_DTSStabHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_DTSStabChest'
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
