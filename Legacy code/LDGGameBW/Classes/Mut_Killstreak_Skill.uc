class Mut_Killstreak_Skill extends Mut_Killstreak
	HideDropDown
	CacheExempt;

function SpawnStreakGR()
{
	local Rules_Killstreak_Skill G;
	
	G = spawn(class'Rules_Killstreak_Skill');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(G);
	G.Mut = self;
}

defaultproperties
{
}
