class KillstreakConfig extends Object
	config(BallisticProV55);

var() globalconfig string		Killstreaks[2];
var()	globalconfig int		Layouts[2];
var()	globalconfig int		Camos[2];

static function UpdateStreaks(string ks1, string ks2)
{
	Log("KillstreakConfig: Attempting killstreak update: "$ks1$", "$ks2);
	
	default.Killstreaks[0] = ks1;
	default.Killstreaks[1] = ks2;

	class'KillstreakConfig'.static.StaticSaveConfig();

	Log("KillstreakConfig: Updated killstreaks:"$default.Killstreaks[0]$", "$default.Killstreaks[1]);
}

defaultproperties 
{
	Killstreaks(0)="BallisticProV55.MRocketLauncher"
	Killstreaks(1)="BallisticProV55.RX22AFlamer"
	Layouts(0)=0
	Layouts(1)=0
	Camos(0)=0
	Camos(1)=0
}