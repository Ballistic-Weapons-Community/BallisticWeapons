//=============================================================================
// T10Rolled.
//
// Rolled underhand T10
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class T10Rolled extends T10Thrown;

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
     FireModeNum=1
     DampenFactor=0.200000
     DampenFactorParallel=0.7
}
