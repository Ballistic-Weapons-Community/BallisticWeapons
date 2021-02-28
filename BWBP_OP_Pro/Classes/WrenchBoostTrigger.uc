class WrenchBoostTrigger extends Trigger;

var float	ZForce;
var float	BoostForce;
var sound	JumpSound;
var byte	Team;

event Touch(actor Other)
{
	if (xPawn(Other) != None && (Team == 255 || xPawn(Other).PlayerReplicationInfo != None && xPawn(Other).PlayerReplicationInfo.Team.TeamIndex == Team))
	{
		PendingTouch = Other.PendingTouch;
		Other.PendingTouch = self;
	}
}

event PostTouch(Actor Other)
{
	local Vector Dir;
	
	if (xPawn(Other) != None)
	{
		Dir = Normal(Other.Velocity);
		Dir.Z = 0;
	
		if ( Other.Physics == PHYS_Walking )
			Other.SetPhysics(PHYS_Falling);
		Other.Velocity.Z = ZForce;
		Other.Velocity += Dir * BoostForce;
		Other.Acceleration = vect(0,0,0);
		Other.PlaySound(JumpSound);
		if(BallisticPawn(Other) != None)
			Pawn(Other).bDirectHitWall=True;
	}
}

defaultproperties
{
     ZForce=1100.000000
     BoostForce=0.000000
     JumpSound=Sound'PickupSounds.AdrenelinPickup'
     TransientSoundVolume=1.000000
     CollisionRadius=64.000000
     CollisionHeight=32.000000
}
