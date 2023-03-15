class BallisticGameStyles extends Object
	DependsOn(BC_GameStyle)
    abstract;

var private array< class<BC_GameStyle> > 	Styles;
var config BC_GameStyle.EGameStyle 			CurrentStyle;

static final function class<BC_GameStyle> Get(BC_GameStyle.EGameStyle style)
{
	return default.Styles[style];
}

static final function class<BC_GameStyle> GetServerStyle()
{
	return default.Styles[class'BallisticReplicationInfo'.default.GameStyle];
}

// Client's own style - NOT the server's.
static final function class<BC_GameStyle> GetClientLocalStyle()
{
	return default.Styles[default.CurrentStyle];
}

// Client's own style, cast to the right class.
// This function will return None if the current style isn't config.
static final function class<BC_GameStyle_Config> GetClientLocalConfigStyle()
{
	return class<BC_GameStyle_Config>(default.Styles[default.CurrentStyle]);
}

defaultproperties
{
	Styles(0)=class'BC_GameStyle'
	Styles(1)=class'BC_GameStyle_Config'
}