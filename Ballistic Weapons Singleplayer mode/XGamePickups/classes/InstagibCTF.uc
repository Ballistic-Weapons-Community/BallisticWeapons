class InstagibCTF extends xCTFGame;

var globalconfig bool bZoomInstagib;
var globalconfig bool bAllowBoost;
var globalconfig bool bLowGrav;
var localized string ZoomDisplayText, ZoomDescText;


static function bool AllowMutator( string MutatorClassName )
{
	if ( MutatorClassName == "" )
		return false;

	if ( static.IsVehicleMutator(MutatorClassName) )
		return false;
	if ( MutatorClassName ~= "xGame.MutInstagib" )
		return false;
	if ( MutatorClassName ~= "xGame.MutZoomInstagib" )
		return false;

	return super.AllowMutator(MutatorClassName);
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.RulesGroup, "bAllowBoost", class'MutInstagib'.default.BoostDisplayText, 0, 1, "Check");
	PlayInfo.AddSetting(default.RulesGroup, "bZoomInstagib", default.ZoomDisplayText, 0, 1, "Check");
	PlayInfo.AddSetting(default.RulesGroup, "bLowGrav", class'MutLowGrav'.default.Description, 0, 1, "Check");
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "bAllowBoost":			return class'MutInstagib'.default.BoostDescText;
		case "bZoomInstagib":		return default.ZoomDescText;
		case "bLowGrav":			return class'MutLowGrav'.default.Description;
	}

	return Super.GetDescriptionText(PropName);
}

static event bool AcceptPlayInfoProperty(string PropertyName)
{
	if ( InStr(PropertyName, "bWeaponStay") != -1 )
		return false;
	if ( InStr(PropertyName, "bAllowWeaponThrowing") != -1 )
		return false;

	return Super.AcceptPlayInfoProperty(PropertyName);
}

defaultproperties
{
	bZoomInstagib=false
	bAllowBoost=true
	bAllowTrans=false
	bDefaultTranslocator=false
    DecoTextName="XGame.InstagibCTF"
	MutatorClass="xGame.InstagibMutator"
    GameName="Instagib CTF"
    Description="Your team must score flag captures by taking the enemy flag from the enemy base and returning it to their own flag.  If the flag carrier is killed, the flag drops to the ground for anyone to pick up.  If your team's flag is taken, it must be returned (by touching it after it is dropped) before your team can score a flag capture."
    Acronym="ICTF"
    ZoomDisplayText="Allow Zoom"
    ZoomDescText="Instagib rifles have sniper scopes."
}