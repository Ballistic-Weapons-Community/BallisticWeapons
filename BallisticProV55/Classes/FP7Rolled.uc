//=============================================================================
// FP7Rolled.
//
// Rolled underhand FP7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7Rolled extends FP7Thrown;

simulated event PostBeginPlay ()
{
	local Rotator R;

	Super.PostBeginPlay();

	R = Rotation;
	R.Roll = 16384;
	SetRotation(R);
}

defaultproperties
{
	ModeIndex=1
	FireModeNum=1
	DampenFactor=0.200000
	DampenFactorParallel=0.7
	MyRadiusDamageType=Class'BallisticProV55.DTNRP57GrenadeRadius'
}
