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
    bReleaseFireOnDie=False
    bAISilent=True
    bFireOnRelease=True

    AmmoClass=Class'BallisticProV55.Ammo_Knife'

    ShakeRotMag=(X=64.000000,Y=384.000000)
    ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
    ShakeRotTime=2.000000

    // AI
    bInstantHit=True
    bLeadTarget=False
    bTossed=False

    BotRefireRate=0.5
}
