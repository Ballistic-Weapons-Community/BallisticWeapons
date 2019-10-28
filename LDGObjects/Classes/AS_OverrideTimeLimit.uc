class AS_OverrideTimeLimit extends Actor placeable;

var() int MyTimeLimit;

function PostBeginPlay()
{
	if ( Level != none && Level.GRI != none 
		&& ASGameReplicationInfo(Level.GRI) != none )
	{
		if (Level.Game!=none && ASGameInfo(Level.Game)!=none)
		{
			ASGameInfo(Level.Game).RoundTimeLimit=MyTimeLimit;
			//ASGameReplicationInfo(Level.GRI).RoundTimeLimit=MyTimeLimit;
			
			ASGameInfo(Level.Game).RemainingTime = 
				(ASGameInfo(Level.Game).RoundTimeLimit + ASGameInfo(Level.Game).ResetTimeDelay + 1) * 60 * 
				(ASGameInfo(Level.Game).MaxRounds + 2) + ASGameInfo(Level.Game).PracticeTimeLimit;
				
			Level.GRI.RemainingTime = ASGameInfo(Level.Game).RemainingTime;
			
		}
		
	}	
}

defaultproperties
{
     bHidden=True
     bNoDelete=True
}
