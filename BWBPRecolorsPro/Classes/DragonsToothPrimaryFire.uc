//=============================================================================
// DragonsToothPrimaryFire.
//
// Horizontalish swipe attack for the EKS43. Uses melee swpie system to do
// horizontal swipes. When the swipe traces find a player, the trace closest to
// the aim will be used to do the damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothPrimaryFire extends BallisticMeleeFire;

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(0)=(offset=(Yaw=1280))
     SwipePoints(1)=(offset=(Yaw=0))
     SwipePoints(2)=(offset=(Yaw=-1280))
     WallHitPoint=1
     NumSwipePoints=3
     FatiguePerStrike=0.100000
     bCanBackstab=True
     TraceRange=(Min=175.000000,Max=175.000000)
     Damage=140.000000
     DamageType=Class'BWBPRecolorsPro.DT_DTSStabChest'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_DTSStabHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_DTSStabChest'
     KickForce=100
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=256.000000,bAtten=True)
     bAISilent=True
     FireAnim="Stab"
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.800000
}
