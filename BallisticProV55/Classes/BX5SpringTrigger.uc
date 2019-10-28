//=============================================================================
// BX5SpringTrigger.
//
// Trigger to spawn with BX5 Spring Mines
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5SpringTrigger extends Triggers;

function UsedBy( Pawn user )
{
	if (Owner != None && BX5SpringMine(Owner) != None)
		BX5SpringMine(Owner).TryUse(User);
}

singular function Touch(Actor Other)
{
	if (Owner != None && BX5SpringMine(Owner) != None && (Other.bProjTarget || Other.bBlockActors))
		BX5SpringMine(Owner).SteppedOn(Other);
}

defaultproperties
{
     bOnlyAffectPawns=True
     bHardAttach=True
     CollisionRadius=128.000000
     CollisionHeight=128.000000
}
