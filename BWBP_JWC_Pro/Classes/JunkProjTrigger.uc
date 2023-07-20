//=============================================================================
// JunkProjTrigger.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkProjTrigger extends Triggers;

function UsedBy( Pawn user )
{
	if (Owner != None)
		Owner.UsedBy (user);
}

defaultproperties
{
     bOnlyAffectPawns=True
     bHardAttach=True
     CollisionRadius=128.000000
     CollisionHeight=128.000000
}
