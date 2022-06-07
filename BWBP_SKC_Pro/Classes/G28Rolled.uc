//=============================================================================
// T10Rolled.
//
// Rolled underhand T10
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G28Rolled extends G28Thrown;

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
     DampenFactor=0.400000
     DampenFactorParallel=1.000000
}
