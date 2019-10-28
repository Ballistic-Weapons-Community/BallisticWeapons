//=============================================================================
// A909SecondaryFire.
//
// Secondary for the A909 holds back the blades until released for a slower,
// but deadlier stab.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A909SecondaryFire extends BallisticMeleeFire;

event ModeDoFire()
{
	local float f;

	Super.ModeDoFire();

	f = FRand();
	if (f > 0.66)
	{
		PreFireAnim = 'PrepBigHack1';
		FireAnim = 'BigHack1';
	}
	else if (f > 0.33)
	{
		PreFireAnim = 'PrepBigHack2';
		FireAnim = 'BigHack2';
	}
	else
	{
		PreFireAnim = 'PrepBigHack3';
		FireAnim = 'BigHack3';
	}
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SwipePoints(1)=(offset=(Yaw=1500))
     SwipePoints(3)=(offset=(Yaw=-1500))
     SwipePoints(4)=(offset=(Yaw=3000))
     WallHitPoint=1
     FatiguePerStrike=0.200000
     TraceRange=(Min=130.000000,Max=130.000000)
     Damage=80.000000
     DamageType=Class'BallisticProV55.DTA909Blades'
     DamageTypeHead=Class'BallisticProV55.DTA909Head'
     DamageTypeArm=Class'BallisticProV55.DTA909Limb'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.A909.A909Slash',Radius=378.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepBigHack3"
     FireAnim="BigHack3"
     FireRate=1.000000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
