//Configuration class for Evolution variables (skill-based weapon unlocking.)
//Affects both Evolution Loadout and Spatial Loadout.
class Mut_LoadoutConfig extends Mutator
	config(BallisticProV55);

var() globalconfig float	TimeScale;
var() globalconfig float	FragScale;
var() globalconfig float	EffyScale;
var() globalconfig float	DmRtScale;
var() globalconfig float	SgEfScale;
var() globalconfig float	SrEfScale;
var() globalconfig float	HzEfScale;

var() localized string	DisplayText[7];
var() localized string	DescriptionText[7];

event PreBeginPlay()
{
	Destroy();
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.GameGroup, "TimeScale",			GetDisplayText("TimeScale"),			50, 1, "Text", "8;0.0:10.0"	,,     	,True);
	PlayInfo.AddSetting(default.GameGroup, "FragScale",			GetDisplayText("FragScale"),			50, 1, "Text", "8;0.0:10.0"	,,     	,True);
	PlayInfo.AddSetting(default.GameGroup, "EffyScale",			GetDisplayText("EffyScale"),			50, 1, "Text", "8;0.0:10.0"	,,     	,True);
	PlayInfo.AddSetting(default.GameGroup, "DmRtScale",			GetDisplayText("DmRtScale"),			50, 1, "Text", "8;0.0:10.0"	,,     	,True);
	PlayInfo.AddSetting(default.GameGroup, "SgEfScale",			GetDisplayText("SgEfScale"),			50, 1, "Text", "8;0.0:10.0"	,,     	,True);
	PlayInfo.AddSetting(default.GameGroup, "SrEfScale",			GetDisplayText("SrEfScale"),			50, 1, "Text", "8;0.0:10.0"	,,     	,True);
	PlayInfo.AddSetting(default.GameGroup, "HzEfScale",			GetDisplayText("HzEfScale"),			50, 1, "Text", "8;0.0:10.0"	,,     	,True);
}

static event string GetDisplayText( string PropName )
{
	switch (PropName)
	{
	case "TimeScale":		return default.DisplayText[0];
	case "FragScale":		return default.DisplayText[1];
	case "EffyScale":		return default.DisplayText[2];
	case "DmRtScale":		return default.DisplayText[3];
	case "SgEfScale":		return default.DisplayText[4];
	case "SrEfScale":		return default.DisplayText[5];
	case "HzEfScale":		return default.DisplayText[6];
	}
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
	case "TimeScale":		return default.DescriptionText[0];
	case "FragScale":		return default.DescriptionText[1];
	case "EffyScale":		return default.DescriptionText[2];
	case "DmRtScale":		return default.DescriptionText[3];
	case "SgEfScale":		return default.DescriptionText[4];
	case "SrEfScale":		return default.DescriptionText[5];
	case "HzEfScale":		return default.DescriptionText[6];
	}
}

defaultproperties
{
     TimeScale=1.000000
     FragScale=1.000000
     EffyScale=1.000000
     DmRtScale=1.000000
     SgEfScale=1.000000
     SrEfScale=1.000000
     HzEfScale=1.000000
     DisplayText(0)="Scale: Time"
     DisplayText(1)="Scale: Frags"
     DisplayText(2)="Scale: Efficiency"
     DisplayText(3)="Scale: Damage Rate"
     DisplayText(4)="Scale: Shotgun Efficiency"
     DisplayText(5)="Scale: Sniper Efficiency"
     DisplayText(6)="Scale: Hazard Efficiency"
     DescriptionText(0)="Scales the Time requirements of all weapons."
     DescriptionText(1)="Scales the Frag requirements of all weapons."
     DescriptionText(2)="Scales the Efficiency requirements of all weapons."
     DescriptionText(3)="Scales the Damage Rate requirements of all weapons."
     DescriptionText(4)="Scales the Shotgun Efficiency requirements of all weapons."
     DescriptionText(5)="Scales the Sniper Efficiency requirements of all weapons."
     DescriptionText(6)="Scales the Hazard Efficiency requirements of all weapons."
     FriendlyName="BallisticPro: Evolution Scaling"
     Description="You can use this mutator to set requirement scaling for the mutators which use Ballistic Evolution.||http://www.runestorm.com"
}
