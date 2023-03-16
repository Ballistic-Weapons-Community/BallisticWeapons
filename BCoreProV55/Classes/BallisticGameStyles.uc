class BallisticGameStyles extends Object
	abstract
	DependsOn(BC_GameStyle)
    config(System);

var private array< class<BC_GameStyle> > 	Styles;
var config BC_GameStyle.EGameStyle 			CurrentStyle;

static final function class<BC_GameStyle> Get(BC_GameStyle.EGameStyle style)
{
	return default.Styles[style];
}

// Style in use by the current game.
static final function class<BC_GameStyle> GetReplicatedStyle()
{
	return default.Styles[class'BallisticReplicationInfo'.default.GameStyle];
}

// Style configured for the local instance of the game.
static final function class<BC_GameStyle> GetLocalStyle()
{
	return default.Styles[default.CurrentStyle];
}

// Style configured for the local instance of the game, cast to the right class.
// This function will return None if the current style isn't config.
static final function class<BC_GameStyle_Config> GetLocalConfigStyle()
{
	return class<BC_GameStyle_Config>(default.Styles[default.CurrentStyle]);
}

defaultproperties
{
	Styles(0)=class'GameStyle_Pro'
	Styles(1)=class'GameStyle_Classic'
	Styles(2)=class'GameStyle_Realism'
	Styles(3)=class'GameStyle_Tactical'
}