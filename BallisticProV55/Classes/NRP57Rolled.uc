//=============================================================================
// NRP57Rolled.
//
// Is no longer Karma-based due to desynch issues.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class NRP57Rolled extends NRP57Thrown;

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
     ImpactDamage=10
     MyRadiusDamageType=Class'BallisticProV55.DTNRP57RolledRadius'
}
