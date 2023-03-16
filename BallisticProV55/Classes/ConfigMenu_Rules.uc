//=============================================================================
// ConfigMenuBase
//
// Rules / inventory configuration menu for configurable game styles.
//
// by Nolan "Dark Carnivour" Richert and Azarael
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ConfigMenu_Rules extends ConfigMenuBase;

// WIP
var() localized string		GameTabLabel,GameTabHint;
var() localized string		WeaponsTabLabel,WeaponsTabHint;
var() localized string		PlayerTabLabel,PlayerTabHint;
var() localized string		MovementTabLabel,MovementTabHint;
var() localized string		PickupsTabLabel,PickupsTabHint;

var() localized string		ConflictTabLabel, ConflictTabHint;
var() localized string		LoadoutTabLabel,LoadoutTabHint;
var() localized string		LoadoutNewTabLabel,LoadoutNewTabHint;
var() localized string		SwapTabLabel,SwapTabHint;
var() localized string		ArenaTabLabel, ArenaTabHint;

function AddTabs()
{
	//WIP
	c_Tabs.AddTab(GameTabLabel,"BallisticProV55.ConfigTab_GameRules",,GameTabHint);
	c_Tabs.AddTab(WeaponsTabLabel,"BallisticProV55.ConfigTab_WeaponRules",,WeaponsTabHint);
	c_Tabs.AddTab(PlayerTabLabel,"BallisticProV55.ConfigTab_PlayerRules",,PlayerTabHint);
	c_Tabs.AddTab(MovementTabLabel,"BallisticProV55.ConfigTab_MovementRules",,MovementTabHint);	
	c_Tabs.AddTab(PickupsTabLabel,"BallisticProV55.ConfigTab_PickupRules",,PickupsTabHint);

	//Inventory
	c_Tabs.AddTab(ConflictTabLabel,"BallisticProV55.ConfigTab_Conflict",,ConflictTabHint);
	c_Tabs.AddTab(LoadoutTabLabel,"BallisticProV55.ConfigTab_Outfitting",,LoadoutTabHint);
	c_Tabs.AddTab(LoadoutNewTabLabel,"BallisticProV55.ConfigTab_Loadout",,LoadoutNewTabHint);
	c_Tabs.AddTab(SwapTabLabel,"BallisticProV55.ConfigTab_Swappings",,SwapTabHint);
	c_Tabs.AddTab(ArenaTabLabel,"BallisticProV55.ConfigTab_Arena",,ArenaTabHint);
}

defaultproperties
{ 
	HeaderCaption="Ballistic Configuration"
	
	// rules
	GameTabLabel="Game"
	GameTabHint="General game rules and settings."
	WeaponsTabLabel="Weapons"
	WeaponsTabHint="Weapon rules and settings."
	PlayerTabLabel="Player"
	PlayerTabHint="Player character rules and settings."
	PickupsTabLabel="Pickups"
	PickupsTabHint="Pickup rules and settings."
	MovementTabLabel="Movement"
	MovementTabHint="Movement rules and settings."

	// inventory
	ConflictTabLabel="Conflict Loadout"
	ConflictTabHint="Change which weapons are used by the 'Ballistic Conflict' Mutator."
	LoadoutTabLabel="Loadout"
	LoadoutTabHint="Change how and which weapons are used by the 'Ballistic Loadout' mutator."
	LoadoutNewTabLabel="Evolution Loadout"
	LoadoutNewTabHint="Adjust the loadout and requirement settings for the 'Ballistic Evolution Loadout' mutator."
	SwapTabLabel="Pickups"
	SwapTabHint="Adjust how and which weapons are spawned by the 'Ballistic Weapons' mutator."
	ArenaTabLabel="Arena"
	ArenaTabHint"Change which weapons are used by the 'Ballistic Arena' Mutator."
}
