class BallisticKillstreakRules extends GameRules;

var Mut_Killstreak Mut;
var array<byte> SpreeThresholds[2];

function ScoreKill(Controller Killer, Controller Killed)
{
	local int i;
	local PlayerController PC;
	local KillstreakLRI KLRI;
	
	PC = PlayerController(Killer);
	
	KLRI = class'Mut_Killstreak'.static.GetKLRI(Killer.PlayerReplicationInfo);
		
	if (PC != None && Killer != Killed && PC.Pawn != None)
	{
		for(i=0; i < 2; i++)
		{
			if (PC.Pawn.GetSpree() == SpreeThresholds[i] && !bool(Mut.GetStreakLevel(PC) & (i+1)) && !bool(KLRI.ActiveStreak & (i+1))) //has a streak of this level, active or otherwise
			{
				Mut.FlagStreak(PC, 2 ** i);
				PC.ReceiveLocalizedMessage( class'BallisticKillstreakMessage', i+1);
			    break;
			}
		}	
	}
	
	if (PlayerController(Killed) != None && BallisticPawn(Killed.Pawn) != None)
	{
		KLRI = class'Mut_Killstreak'.static.GetKLRI(Killed.PlayerReplicationInfo);
		if (KLRI.ActiveStreak > 0)
			Mut.ResetActiveStreaks(PlayerController(Killed));
	}
	
	if ( NextGameRules != None )
	NextGameRules.ScoreKill(Killer,Killed);				
}

defaultproperties
{
     SpreeThresholds(0)=4
     SpreeThresholds(1)=9
}
