//=============================================================================
// RiotSecondaryFire.
//
// Held bash-back for the riot shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticShieldSecondaryFire extends BallisticMeleeFire;

function PlayPreFire()
{
	if (FRand() > 0.5)
	{
		PreFireAnim = 'PrepSmash';
		FireAnim = 'Smash';
	}
	else
	{
		PreFireAnim = 'PrepSmashAlt';
		FireAnim = 'SmashAlt';
	}
	super.PlayPreFire();
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
	 TraceRange=(Min=150.000000,Max=150.000000)
     WallHitPoint=1
     NumSwipePoints=3
     FatiguePerStrike=0.50000
     Damage=80.000000
     
     
     DamageType=Class'BWBPOtherPackPro.DTBallisticShield'
     DamageTypeHead=Class'BWBPOtherPackPro.DTBallisticShield'
     DamageTypeArm=Class'BWBPOtherPackPro.DTBallisticShield'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepSmashAlt"
     FireAnim="SmashAlt"
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
