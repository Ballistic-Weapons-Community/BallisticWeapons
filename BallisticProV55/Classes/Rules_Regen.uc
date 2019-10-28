//=============================================================================
// Rules_Regen.
//
// Allows the killing of players to award health according to the specifications of the Mut_BWRegeneration class.
//
// by Logan "Black Eagle" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Rules_Regen extends GameRules;

function ScoreKill(Controller Killer, Controller Killed)
{
	super.ScoreKill(Killer,Killed);

	if (Killed != None && Killer != None && Killer.Pawn != None && Killer.Pawn.Health > 0 && Killer.Pawn.Health < class'Mut_Regeneration'.Default.HealthBonusCap)
	{
		if(Vehicle(Killer.Pawn) == None)
			Killer.Pawn.Health = Clamp(Killer.Pawn.Health+class'Mut_Regeneration'.Default.HealthBonus,0,class'Mut_Regeneration'.Default.HealthBonusCap);
		else
			Vehicle(Killer.Pawn).Driver.Health = Clamp(Vehicle(Killer.Pawn).Driver.Health+class'Mut_Regeneration'.Default.HealthBonus,0,class'Mut_Regeneration'.Default.HealthBonusCap);
	}
}

defaultproperties
{
}
