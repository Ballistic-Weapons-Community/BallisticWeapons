class KillstreakConfig extends Object
	config(BallisticProV55);

var config string		Killstreaks[2];

static function UpdateStreaks(string new_killstreaks[2])
{
	local int i;
	
	default.Killstreaks[0] = new_killstreaks[0];
	default.Killstreaks[1] = new_killstreaks[1];

	StaticSaveConfig();
}

defaultproperties 
{
	
}