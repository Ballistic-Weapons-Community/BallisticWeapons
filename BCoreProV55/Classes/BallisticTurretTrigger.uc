//=============================================================================
// BallisticTurretTrigger.
//
// Trigger for using turrets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticTurretTrigger extends Triggers;

function UsedBy( Pawn User )
{
	if (Vehicle(Owner) != None)
		Vehicle(Owner).TryToDrive(User);
}

defaultproperties
{
     bOnlyAffectPawns=True
     CollisionRadius=96.000000
     CollisionHeight=96.000000
}
