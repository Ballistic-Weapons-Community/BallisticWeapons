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

var() localized string		WeaponListsTabLabel, WeaponListsTabHint;

function AddTabs()
{
	//WIP
	c_Tabs.AddTab(GameTabLabel,"BallisticProV55.ConfigTab_GameRules",,GameTabHint);
	c_Tabs.AddTab(WeaponsTabLabel,"BallisticProV55.ConfigTab_WeaponRules",,WeaponsTabHint);
	c_Tabs.AddTab(PlayerTabLabel,"BallisticProV55.ConfigTab_PlayerRules",,PlayerTabHint);
	c_Tabs.AddTab(MovementTabLabel,"BallisticProV55.ConfigTab_MovementRules",,MovementTabHint);	
	c_Tabs.AddTab(PickupsTabLabel,"BallisticProV55.ConfigTab_PickupRules",,PickupsTabHint);

	// the inventory modes' weapon lists, in one tab
	c_Tabs.AddTab(WeaponListsTabLabel,"BallisticProV55.ConfigTab_WeaponLists",,WeaponListsTabHint);
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


	WeaponListsTabLabel="Weapon Lists"
	WeaponListsTabHint="The weapons of each inventory mode: Inventory, Loadout, Evolution, Pickup Swaps and Arena."
}
