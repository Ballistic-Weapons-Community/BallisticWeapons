// Streaks for Invasion. Work based on score and are ini-config only.
class BallisticInvKillstreakRules extends GameRules
	config(BallisticProV55);

var Mut_Killstreak Mut;
var config array<int> InvSpreeThresholds[2];

function ScoreKill(Controller Killer, Controller Killed)
{
	local int i, OldScore;
	local PlayerController PC;
	local KillstreakLRI KLRI;
		
	PC = PlayerController(Killer);
		
	if (PC != None && Killer != Killed && PC.Pawn != None)
	{
		KLRI = class'Mut_Killstreak'.static.GetKLRI(PC.PlayerReplicationInfo);
		if (KLRI != None)
		{
			OldScore = KLRI.InvKillScore;
			
			if ( Invasion(Level.Game).LastKilledMonsterClass == None )
				KLRI.InvKillScore += 1;
			else
				KLRI.InvKillScore += Invasion(Level.Game).LastKilledMonsterClass.Default.ScoringValue;
			
			for(i=0; i < 2; i++)
			{
				if (OldScore >= InvSpreeThresholds[i])
					continue;
				if (KLRI.InvKillScore >= InvSpreeThresholds[i] && bool(Mut.GetStreakLevel(PC) & (2 ** i)))
				{
					Mut.FlagStreak(PC, i+1);
					PC.ReceiveLocalizedMessage( class'BallisticKillstreakMessage', i+1);
					break;
				}
			}
		 }
	}
	
	if (PlayerController(Killed) != None && BallisticPawn(Killed.Pawn) != None && BallisticPawn(Killed.Pawn).bActiveKillstreak) //FIXME: check linked pri instead
		Mut.ResetActiveStreaks(PlayerController(Killed));
	
	if ( NextGameRules != None )
		NextGameRules.ScoreKill(Killer,Killed);				
}

defaultproperties
{
     InvSpreeThresholds(0)=150
     InvSpreeThresholds(1)=350
}
