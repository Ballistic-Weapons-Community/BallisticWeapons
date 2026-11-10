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

var() localized string		WeaponListsTabLabel, WeaponListsTabHint;

function AddTabs()
{
	// rules
	c_Tabs.AddTab(GameTabLabel,"BallisticProV55.ConfigTab_GameRules",,GameTabHint);

	// the inventory modes' weapon lists, in one tab
	c_Tabs.AddTab(WeaponListsTabLabel,"BallisticProV55.ConfigTab_WeaponLists",,WeaponListsTabHint);
}

defaultproperties
{
	HeaderCaption="Ballistic Configuration"

	GameTabLabel="Game"
	GameTabHint="Adjust rules and settings that affect the behaviour of the game."
	

	WeaponListsTabLabel="Weapon Lists"
	WeaponListsTabHint="The weapons of each inventory mode: Inventory, Loadout, Evolution, Pickup Swaps and Arena."
}
