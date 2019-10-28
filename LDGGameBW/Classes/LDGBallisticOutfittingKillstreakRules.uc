class LDGBallisticOutfittingKillstreakRules extends GameRules;

var Mut_Outfitting Mut;

function ScoreKill(Controller Killer, Controller Killed)
{
	local int i;
	local PlayerController PC;
	local BallisticPlayerReplicationInfo BPRI;
	local UTComp_PRI_BW_FR_LDG uPRI;
	
	PC = PlayerController(Killer);
	
	if (PC != None)
		uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PC.PlayerReplicationInfo));
		
	if(uPRI != None && Killer != Killed && PC.Pawn != None)
	{
		for(i=0; i < 2; i++)
		{
			if (PC.Pawn.GetSpree() == uPRI.KSThresh[i] && !bool(Mut.GetStreakLevel(PC) & (2 ** i))) //has a streak of this level
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
}
