//=============================================================================
// RiotSecondaryFire.
//
// Held bash-back for the riot shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RiotSecondaryFire extends BallisticMeleeFire;

event ModeDoFire()
{
	Super.ModeDoFire();
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     Damage=100.000000
     DamageHead=100.000000
     DamageLimb=100.000000
     DamageType=Class'BallisticProV55.DTRiotShield'
     DamageTypeHead=Class'BallisticProV55.DTRiotShield'
     DamageTypeArm=Class'BallisticProV55.DTRiotShield'
     KickForce=20000
     HookStopFactor=1.700000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim=
     FireAnim=
     FireRate=1.600000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=512.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
