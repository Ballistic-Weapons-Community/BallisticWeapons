//=============================================================================
// ConfigMenuBase
//
// This menu is like an options menu for the Ballistic Weapons mod.
// It has settings for the mutator and game like rules and so on which are kept
// server side and preference type options that are kept client side.
// OK: saves and exits, Cancel: exits without save, Reset: undoes all changes
// Defaults: resets everything to default
//
// by Nolan "Dark Carnivour" Richert and Azarael
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigMenu_Preferences extends ConfigMenuBase;

// Preferences
var() localized string		GameplayTabLabel,GameplayTabHint;
var() localized string		VisualTabLabel,VisualTabHint;
var() localized string		BloodTabLabel,BloodTabHint;
var() localized string		CrossTabLabel,CrossTabHint;

var() localized string		DetailSettings[9];

function AddTabs()
{
	//Preferences
	c_Tabs.AddTab(GameplayTabLabel,"BallisticProV55.ConfigTab_GameplayPrefs",,GameplayTabHint);
	c_Tabs.AddTab(VisualTabLabel,"BallisticProV55.ConfigTab_VisualPrefs",,VisualTabHint);
	c_Tabs.AddTab(BloodTabLabel,"BallisticProV55.ConfigTab_Blood",,BloodTabHint);
	c_Tabs.AddTab(CrossTabLabel,"BallisticProV55.ConfigTab_Crosshairs",,CrossTabHint);
}

final function string GetDisplayString(string ConfigString)
{
	local int i;

	for (i = 0; i < 9; i++)
	{
		if (DetailSettings[i] ~= ConfigString)
			return class'UT2K4Tab_DetailSettings'.default.DetailLevels[i];
	}

	return "";
}

final function string GetConfigString(string DisplayString)
{
	local int i;

	for (i = 0; i < 9; i++)
	{
		if (class'UT2K4Tab_DetailSettings'.default.DetailLevels[i] ~= DisplayString)
			return DetailSettings[i];
	}

	return "";
}

defaultproperties
{
     //WIP
	 HeaderCaption="Ballistic Preferences"

     GameplayTabLabel="Gameplay"
     GameplayTabHint="Configure gameplay preferences."

     VisualTabLabel="Visual"
     VisualTabHint="Configure visual preferences."

	 BloodTabLabel="Blood"
     BloodTabHint="Configure blood and gore settings."
	 
     CrossTabLabel="Graphical Crosshairs"
     CrossTabHint="Configure the graphical crosshairs."

	 DetailSettings(0)="UltraLow"
     DetailSettings(1)="VeryLow"
     DetailSettings(2)="Low"
     DetailSettings(3)="Lower"
     DetailSettings(4)="Normal"
     DetailSettings(5)="Higher"
     DetailSettings(6)="High"
     DetailSettings(7)="VeryHigh"
     DetailSettings(8)="UltraHigh"
}
