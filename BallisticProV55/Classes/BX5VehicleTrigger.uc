//=============================================================================
// BX5VehicleTrigger.
//
// Trigger to spawn with BX5 Vehicle Mines
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5VehicleTrigger extends Triggers;

function UsedBy( Pawn user )
{
	if (Owner != None && BX5VehicleMine(Owner) != None)
		BX5VehicleMine(Owner).TryUse(User);
}

singular function Touch(Actor Other)
{
	if (Owner != None && BX5VehicleMine(Owner) != None && (Other.bProjTarget || Other.bBlockActors))
	{
		if (abs(Other.Location.Z - Location.Z) - other.CollisionHeight > 64 && (Vehicle(Other)==None || (!Vehicle(Other).bCanHover && !Vehicle(Other).bCanFly)))
			return;
		BX5VehicleMine(Owner).SteppedOn(Other);
	}
}

defaultproperties
{
     bOnlyAffectPawns=True
     bHardAttach=True
     CollisionRadius=48.000000
     CollisionHeight=128.000000
}
