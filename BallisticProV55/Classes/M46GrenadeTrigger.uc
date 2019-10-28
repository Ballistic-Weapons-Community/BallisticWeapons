//=============================================================================
// M46GrenadeTrigger.
//
// Trigger to spawn with M46 Proximity Mines
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46GrenadeTrigger extends Triggers;

function UsedBy( Pawn user )
{
	if (Owner != None && M46ProximityMine(Owner) != None)
		M46ProximityMine(Owner).TryUse(User);
}

simulated singular function Touch(Actor Other)
{
	if (Owner != None && M46ProximityMine(Owner) != None && (Other.bProjTarget || Other.bBlockActors))
		M46ProximityMine(Owner).SteppedOn(Other);
}

defaultproperties
{
     bOnlyAffectPawns=True
     bHardAttach=True
     CollisionRadius=192.000000
     CollisionHeight=192.000000
}
