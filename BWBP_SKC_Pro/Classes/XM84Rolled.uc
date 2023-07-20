//=============================================================================
// XM84Rolled.
//
// A fancy Karama based grenaded that is intended to behave more like a grenade
// that is rolled along the ground. Detonates 4 seconds after clip is released.
// The pineapple is not too effective a weapon in the hands of the amatuer, but
// once the user masters the timing, it will become a very deadly toy. Throw
// directly at opponents to provide them with a nasty concussion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM84Rolled extends XM84Thrown;

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
	DampenFactor=0.100000
	DampenFactorParallel=0.7
	ImpactDamage=10
}
