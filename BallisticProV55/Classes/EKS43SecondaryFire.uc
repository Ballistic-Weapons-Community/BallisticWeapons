//=============================================================================
// EKS43SecondaryFire.
//
// Vertical/Diagonal held swipe for the EKS43. Uses swipe system and is prone
// to headshots because the highest trace that hits an enemy will be used to do
// the damage and check hit area.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class EKS43SecondaryFire extends BallisticMeleeFire;

event ModeDoFire()
{
	if (FRand() > 0.5)
	{
		PreFireAnim = 'PrepHack1';
		FireAnim = 'Hack1';
	}
	else
	{
		PreFireAnim = 'PrepHack2';
		FireAnim = 'Hack2';
	}
	Super.ModeDoFire();
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(0)=(offset=(Yaw=-1536))
     SwipePoints(1)=(offset=(Yaw=0))
     SwipePoints(2)=(offset=(Yaw=1536))
     WallHitPoint=1
     NumSwipePoints=3
     FatiguePerStrike=0.250000
     TraceRange=(Min=155.000000,Max=155.000000)
     Damage=75.000000
     DamageType=Class'BallisticProV55.DTEKS43Katana'
     DamageTypeHead=Class'BallisticProV55.DTEKS43KatanaHead'
     DamageTypeArm=Class'BallisticProV55.DTEKS43KatanaLimb'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.EKS43.EKS-Slash',Volume=0.35,Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepHack1"
     FireAnim="Hack1"
     FireRate=1.200000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=512.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.500000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.5
}
