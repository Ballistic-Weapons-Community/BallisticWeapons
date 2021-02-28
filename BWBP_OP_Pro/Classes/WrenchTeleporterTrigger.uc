class WrenchTeleporterTrigger extends Trigger;

var WrenchTeleporterTrigger OtherWarp;
var byte Team;

event UsedBy(Pawn Other)
{
	if (OtherWarp == None || OtherWarp == Self)
		return;
	if (xPawn(Other) != None && !xPawn(Other).bJustTeleported && OtherWarp != None && (Team == 255 || xPawn(Other).PlayerReplicationInfo.Team.TeamIndex == Team))
	{
		PendingTouch = Other.PendingTouch;
		Other.PendingTouch = self;
	}
}

event PostTouch(Actor Other)
{
	local Controller OtherPlayer;

	if (xPawn(Other) != None)
	{
		if ( !Other.SetLocation(OtherWarp.Location + vect(0,0,32)) )
		{
			log(self$" Teleport failed");
			return;
		}
		if (Role == ROLE_Authority)
		{
			For ( OtherPlayer=Level.ControllerList; OtherPlayer !=None; OtherPlayer=OtherPlayer.NextController )
				if ( OtherPlayer.Enemy == self )
					OtherPlayer.LineOfSightTo(self); 
			xPawn(Other).SetRotation(OtherWarp.Rotation);
			xPawn(Other).SetViewRotation(OtherWarp.Rotation);
			xPawn(Other).ClientSetRotation(OtherWarp.Rotation);
			Other.Velocity=Vect(0,0,0);
		}
		if ( xPawn(Other).Controller != None )
			xPawn(Other).Controller.MoveTimer = -1.0;

		xPawn(Other).PlayTeleportEffect(true, true);
		
		return;
	}
}

defaultproperties
{
     CollisionRadius=64.000000
     CollisionHeight=48.000000
}
