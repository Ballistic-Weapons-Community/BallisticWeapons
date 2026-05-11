//=============================================================================
// Rules_Regen.
//
// Allows the killing of players to award health according to the specifications of the Mut_BWRegeneration class.
//
// by Logan "Black Eagle" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Rules_Regen extends GameRules;

function ScoreKill(Controller Killer, Controller Killed)
{
	local Vehicle V;

	super.ScoreKill(Killer,Killed);

	if (Killed != None && Killer != None && Killer.Pawn != None && Killer.Pawn.Health > 0 && Killer.Pawn.Health < class'Mut_Regeneration'.Default.HealthBonusCap)
	{
		V = Vehicle(Killer.Pawn);
		if (V == None)
			Killer.Pawn.Health = Clamp(Killer.Pawn.Health+class'Mut_Regeneration'.Default.HealthBonus,0,class'Mut_Regeneration'.Default.HealthBonusCap);
		// Turrets and unoccupied vehicles can score kills without a Driver (e.g. automated turret projectiles).
		else if (V.Driver != None)
			V.Driver.Health = Clamp(V.Driver.Health+class'Mut_Regeneration'.Default.HealthBonus,0,class'Mut_Regeneration'.Default.HealthBonusCap);
	}
}

defaultproperties
{
}
