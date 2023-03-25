//=============================================================================
// ConfigMenu_Inventory
//
// Configuration menu used for fixed game styles.
//
// by Nolan "Dark Carnivour" Richert and Azarael
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigMenu_Inventory extends ConfigMenuBase;

var() localized string		GameTabLabel,GameTabHint;

var() localized string		ConflictTabLabel, ConflictTabHint;
var() localized string		LoadoutTabLabel,LoadoutTabHint;
var() localized string		LoadoutNewTabLabel,LoadoutNewTabHint;
var() localized string		SwapTabLabel,SwapTabHint;
var() localized string		ArenaTabLabel, ArenaTabHint;

function AddTabs()
{
	// rules
	c_Tabs.AddTab(GameTabLabel,"BallisticProV55.ConfigTab_GameRules",,GameTabHint);

	//Inventory
	c_Tabs.AddTab(ConflictTabLabel,"BallisticProV55.ConfigTab_ConflictLoadout",,ConflictTabHint);
	c_Tabs.AddTab(LoadoutTabLabel,"BallisticProV55.ConfigTab_Outfitting",,LoadoutTabHint);
	c_Tabs.AddTab(LoadoutNewTabLabel,"BallisticProV55.ConfigTab_Loadout",,LoadoutNewTabHint);
	c_Tabs.AddTab(SwapTabLabel,"BallisticProV55.ConfigTab_Swappings",,SwapTabHint);
	c_Tabs.AddTab(ArenaTabLabel,"BallisticProV55.ConfigTab_Arena",,ArenaTabHint);
}

defaultproperties
{
	HeaderCaption="Ballistic Configuration"

	GameTabLabel="Game"
	GameTabHint="Adjust rules and settings that affect the behaviour of the game."
	
	ArenaTabLabel="Arena"
	ArenaTabHint"Change which weapons are used by the 'Ballistic Arena' Mutator."
	ConflictTabLabel="Conflict Loadout"
	ConflictTabHint="Change which weapons are used by the 'Ballistic Conflict' Mutator."
	SwapTabLabel="Swapping"
	SwapTabHint="Adjust how and which weapons are spawned by the 'Ballistic Weapons' mutator."
	LoadoutTabLabel="Loadout"
	LoadoutTabHint="Change how and which weapons are used by the 'Ballistic Loadout' mutator."
	LoadoutNewTabLabel="Evolution Loadout"
	LoadoutNewTabHint="Adjust the loadout and requirement settings for the 'Ballistic Evolution Loadout' mutator."
}
