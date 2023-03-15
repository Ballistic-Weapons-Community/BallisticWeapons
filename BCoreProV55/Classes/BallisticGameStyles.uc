class BallisticGameStyles extends Object
	DependsOn(BC_GameStyle)
    abstract;

var private array< class<BC_GameStyle> > 	Styles;
var config BC_GameStyle.EGameStyle 			CurrentStyle;

static final function class<BC_GameStyle> Get(BC_GameStyle.EGameStyle style)
{
	return default.Styles[style];
}

static final function class<BC_GameStyle> GetConfigStyle()
{
	return default.Styles[default.CurrentStyle];
}

defaultproperties
{
	Styles(0)=class'BC_GameStyle'
	Styles(1)=class'BC_GameStyle_Config'
}