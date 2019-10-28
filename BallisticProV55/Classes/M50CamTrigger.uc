//=============================================================================
// M50CamTrigger.
//
// Trigger to spawn with M50 Cameras so they can be piced up with 'use'.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50CamTrigger extends Triggers;

function UsedBy( Pawn user )
{
	if (Owner != None && M50AssaultRifle(Owner) != None)
		M50AssaultRifle(Owner).TryUse(User);
}

defaultproperties
{
     bOnlyAffectPawns=True
     bHardAttach=True
     CollisionRadius=64.000000
     CollisionHeight=96.000000
}
