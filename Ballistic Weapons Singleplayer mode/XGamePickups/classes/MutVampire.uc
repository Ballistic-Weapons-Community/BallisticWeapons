//=============================================================================
// MutVampire - steals health from other players
//=============================================================================
class MutVampire extends Mutator;

function PostBeginPlay()
{
	local GameRules G;
	
	Super.PostBeginPlay();
	G = spawn(class'VampireGameRules');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else    
		Level.Game.GameRulesModifiers.AddGameRules(G);
	Destroy();
}


defaultproperties
{
    IconMaterialName="MutatorArt.nosym"
    ConfigMenuClassName=""
    GroupName="Vampire"
    FriendlyName="Vampire"
    Description="Damaging your opponents will heal you."
}	
