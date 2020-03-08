class LDGMut_Killstreak extends Mut_Killstreak
	HideDropDown
	CacheExempt;

function SpawnStreakGR()
{
	local LDGBallisticKillstreakRules G;
	
	G = spawn(class'LDGBallisticKillstreakRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(G);
	G.Mut = self;
}

defaultproperties
{
}
