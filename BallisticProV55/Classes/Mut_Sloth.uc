//=============================================================================
// BW-Sloth - Realistic movement mut.
//=============================================================================
class Mut_Sloth extends Mutator 
	config(BallisticProV55);

var config bool bUseSloth;
var config float StrafeScale;
var config float BackScale;
var config float GroundSpeedScale;
var config float AirSpeedScale;
var config float AccelRateScale;

var localized string StrafeText;
var localized string BackText;
var localized string GroundSpeedScaleText;
var localized string AirSpeedScaleText;
var localized string AccelRateScaleText;
var localized string UseSlothText;

var localized string StrafeDesc;
var localized string BackDesc;
var localized string GroundSpeedScaleDesc;
var localized string AirSpeedScaleDesc;
var localized string AccelRateScaleDesc;
var localized string UseSlothDesc;

function ModifyPlayer(Pawn Other)
{
	if (bUseSloth)
	{
		BallisticPawn(Other).StrafeScale = StrafeScale;
		BallisticPawn(Other).BackScale = BackScale;
		BallisticPawn(Other).GroundSpeed = GroundSpeedScale;
		BallisticPawn(Other).AirSpeed = AirSpeedScale;
		BallisticPawn(Other).AccelRate = AccelRateScale;
	}

	Super.ModifyPlayer(Other);
}

static function FillPlayInfo(PlayInfo PlayInfo)
{
	Super.FillPlayInfo(PlayInfo);

	PlayInfo.AddSetting(default.RulesGroup, "bUseSloth", default.UseSlothText, 0, 1,  "Check");
	PlayInfo.AddSetting(default.RulesGroup, "StrafeScale", default.StrafeText, 0, 2, "Text", "8;0.50:1.00",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "BackScale", default.BackText, 0, 3,  "Text", "8;0.50:1.00",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "GroundSpeedScale", default.GroundSpeedScaleText, 0, 4,  "Text", "8;180.000000:540.000000",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "AirSpeedScale", default.AirSpeedScaleText, 0, 5,  "Text", "8;128.000000:1024.000000",,,True);
	PlayInfo.AddSetting(default.RulesGroup, "AccelRateScale", default.AccelRateScaleText, 0, 6,  "Text", "8;128.000000:2048.000000",,,True);
}

static event string GetDisplayText( string PropName )
{
	switch (PropName)
	{
    	case "StrafeText":       return default.StrafeText;
    	case "BackText":           return default.BackText;
    	case "GroundSpeedScale":           return default.GroundSpeedScaleText;
		case "AirSpeedScale":           return default.AirSpeedScaleText;
    	case "AccelRateScale":           return default.AccelRateScaleText;
		case "bUseSloth":				return default.UseSlothText;
	}
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
    	case "StrafeScale":       return default.StrafeDesc;
    	case "BackScale":           return default.BackDesc;
    	case "GroundSpeedScale":           return default.GroundSpeedScaleDesc;
    	case "AirSpeedScale":           return default.AirSpeedScaleDesc;
    	case "AccelRateScale":           return default.AccelRateScaleDesc;
		case "bUseSloth":				return default.UseSlothDesc;
	}

	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
	 bUseSloth=False
     StrafeScale=0.700000
     BackScale=0.600000
     GroundSpeedScale=270.000000
     AirSpeedScale=270.000000
     AccelRateScale=256.000000
	 UseSlothText="Use Sloth"
     StrafeText="Strafe Ground Speed Scale"
     BackText="Backwards Ground Speed Scale"
     GroundSpeedScaleText="Ground Speed"
     AirSpeedScaleText="Air Speed"
     AccelRateScaleText="Ground Acceleration"
	 UseSlothDesc="Adds Sloth mode."
     StrafeDesc="Strafe speed penalty factor, choose value between 0.50 and 1.00, 0.60 is default."
     BackDesc="Backwards speed penalty factor, choose value between 0.50 and 1.00, 0.50 is default."
     GroundSpeedScaleDesc="Ground Speed, choose value between 180 and 540, BW default is 360."
     AirSpeedScaleDesc="Air Speed, choose value between 180 and 540, BW default is 360, best kept same as GroundSpeedScale."
     AccelRateScaleDesc="Acceleration rate, choose value between 128 and 2048, BW Default is 2048."
     bAddToServerPackages=True
     GroupName="SlothMuts"
     FriendlyName="BallisticPro: Sloth"
     Description="BADDER and more realistic movement, and momentum."
     bAlwaysRelevant=True
}
