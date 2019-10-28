//=============================================================================
// RACE_ExtendTimeLimit.
//=============================================================================
class RACE_ExtendTimeLimit extends Actor
	placeable;

var(ExtendTimeLimit) const int ExtraTimeLimit;

function Trigger( Actor Other, Pawn EventInstigator )
{
	local Controller C;
	
	if ( Level != none && Level.GRI != none 
		&& ASGameReplicationInfo(Level.GRI) != none )
	{
		if (Level.Game != None && ASGameInfo(Level.Game)!=none)
		{
			if (!ASGameInfo(Level.Game).IsPracticeRound())
			{
				ASGameInfo(Level.Game).RoundTimeLimit += ExtraTimeLimit;
				ASGameInfo(Level.Game).RemainingTime += ExtraTimeLimit * 60;			
				Level.GRI.RemainingMinute = ASGameInfo(Level.Game).RemainingTime;	
			}		
		}
	}
	
	for ( C=Level.ControllerList; C!=None; C=C.NextController )
	{
		if ( C.Pawn != None && ASPlayerReplicationInfo(C.PlayerReplicationInfo) != None )
			ASPlayerReplicationInfo(C.PlayerReplicationInfo).TeleportTime += ExtraTimeLimit * 60;
	
	}	
}

defaultproperties
{
     bHidden=True
     bNoDelete=True
}
