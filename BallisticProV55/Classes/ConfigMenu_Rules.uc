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
class ConfigMenu_Rules extends ConfigMenuBase;

// WIP
var() localized string		GameTabLabel,GameTabHint;
var() localized string		WeaponsTabLabel,WeaponsTabHint;
var() localized string		PlayerTabLabel,PlayerTabHint;
var() localized string		PickupsTabLabel,PickupsTabHint;
var() localized string		SprintTabLabel,SprintTabHint;
var() localized string		KillRewardsTabLabel,KillRewardsTabHint;

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
	c_Tabs.AddTab(PlayerTabLabel,"BallisticProV55.ConfigTab_Player",,PlayerTabHint);
	c_Tabs.AddTab(PickupsTabLabel,"BallisticProV55.ConfigTab_Pickups",,PickupsTabHint);
	c_Tabs.AddTab(SprintTabLabel,"BallisticProV55.ConfigTab_Sprint",,SprintTabHint);	
	c_Tabs.AddTab(KillRewardsTabLabel,"BallisticProV55.ConfigTab_KillRewards",,KillRewardsTabHint); 

	//Inventory
	c_Tabs.AddTab(ConflictTabLabel,"BallisticProV55.ConfigTab_Conflict",,ConflictTabHint);
	c_Tabs.AddTab(LoadoutTabLabel,"BallisticProV55.ConfigTab_Outfitting",,LoadoutTabHint);
	c_Tabs.AddTab(LoadoutNewTabLabel,"BallisticProV55.ConfigTab_Loadout",,LoadoutNewTabHint);
	c_Tabs.AddTab(SwapTabLabel,"BallisticProV55.ConfigTab_Swappings",,SwapTabHint);
	c_Tabs.AddTab(ArenaTabLabel,"BallisticProV55.ConfigTab_Arena",,ArenaTabHint);
}

defaultproperties
{ 
	ConfiguredStyle=class'BC_GameStyle'

	HeaderCaption="Ballistic Rules"
	
	// rules
	GameTabLabel="Game"
	GameTabHint="Adjust rules and settings that affect the behaviour of the game."
	WeaponsTabLabel="Weapons"
	WeaponsTabHint="Adjust rules and settings that affect the behaviour of the Weapons."
	PlayerTabLabel="Player"
	PlayerTabHint="Adjust rules and settings that affect the Player Settings"
	PickupsTabLabel="Pickups"
	PickupsTabHint="Adjust rules and settings that affect the Equipment Pickup Settings"
	KillRewardsTabLabel="Kill Rewards"
	KillRewardsTabHint="Adjust rules and settings that affect Kill Rewards"
	SprintTabLabel="Movement"
	SprintTabHint="Adjust rules and settings that affect Movement"

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
