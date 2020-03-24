class KillstreakConfig extends Object
	DependsOn(BallisticTab_Killstreaks)
	config(BallisticProV55);

var() globalconfig string		Killstreaks[2];

static function UpdateStreaks(string new_killstreaks[2])
{
	local int i;
	
	default.Killstreaks[0] = new_killstreaks[0];
	default.Killstreaks[1] = new_killstreaks[1];

	StaticSaveConfig();
}

defaultproperties 
{
	Killstreaks(0)="BallisticProV55.MRocketLauncher"
	Killstreaks(1)="BallisticProV55.RX22AFlamer"
}