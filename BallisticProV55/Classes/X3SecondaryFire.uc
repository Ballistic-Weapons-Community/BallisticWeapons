//=============================================================================
// X3SecondaryFire.
//
// Hold fire to draw back the weapon and release to slash out at your opponent.
// Good for sneaking up on enemies.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X3SecondaryFire extends BallisticMeleeFire;

simulated function bool AllowFire()
{
	if (level.TimeSeconds > X3Knife(Weapon).NextThrowTime)
		return super.AllowFire();
	return false;
}

event ModeDoFire()
{
	if (FRand() > 0.5)
	{
		PreFireAnim = 'BigBack1';
		FireAnim = 'BigStab1';
	}
	else
	{
		PreFireAnim = 'BigBack2';
		FireAnim = 'BigSlash1';
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
     FatiguePerStrike=0.200000
     TraceRange=(Min=108.000000,Max=108.000000)
     DamageHead=75.000000
     DamageLimb=75.000000
     DamageType=Class'BallisticProV55.DTX3Knife'
     DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
     DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
     KickForce=100
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bReleaseFireOnDie=False
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds2.Knife.KnifeSlash',Radius=378.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="BigBack1"
     FireAnim="BigStab1"
     FireRate=0.750000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}
