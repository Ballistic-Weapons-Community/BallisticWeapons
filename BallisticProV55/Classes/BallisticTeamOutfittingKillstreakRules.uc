class BallisticTeamOutfittingKillstreakRules extends GameRules;

var Mut_TeamOutfitting Mut;
var array<byte> SpreeThresholds[2];

function ScoreKill(Controller Killer, Controller Killed)
{
	local int i;
	local PlayerController PC;
	local BallisticPlayerReplicationInfo BPRI;
	
	PC = PlayerController(Killer);
		
	if (PC != None && Killer != Killed && PC.Pawn != None)
	{
		for(i=0; i < 2; i++)
		{
			if (PC.Pawn.GetSpree() == SpreeThresholds[i] && bool(Mut.GetStreakLevel(PC) & (2 ** i))) //has a streak of this level
			{
				Mut.FlagStreak(PC, 2 ** i);
				PC.ReceiveLocalizedMessage( class'BallisticKillstreakMessage', i+1);
			    break;
			}
		}	
	}
	
	if (PlayerController(Killed) != None && BallisticPawn(Killed.Pawn) != None)
	{
		BPRI = class'Mut_Ballistic'.static.GetBPRI(Killed.PlayerReplicationInfo);
		if (BPRI.ActiveStreak > 0)
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
