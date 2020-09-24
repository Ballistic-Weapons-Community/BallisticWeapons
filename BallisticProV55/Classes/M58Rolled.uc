//=============================================================================
// M58Rolled.
//
// Rolled underhand M58
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M58Rolled extends M58Thrown;

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
