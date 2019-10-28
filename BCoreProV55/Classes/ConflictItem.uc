//=============================================================================
// ConflictItem.
//
// A special item that can be equipped in Conflict to give bonuses, add
// inventory, modify player, etc...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class ConflictItem extends Actor;

var() localized string	ItemName;	// Friendly name
var() localized string	ItemAmount;	// Quanitiy display text. e.gs: "25%" "+50" "Double"
var() localized string	Description;// Longer description of item. Multi-line Ok
var() int				Size;		// 100 = full
var() Material			Icon;		// Icon to represent this item in UIs

var() bool				bBonusAmmo;	// Use AddAmmoBonus() instead of ApplyItem()

// Apply the item to the player. There's a lot that can be done here...
static function bool ApplyItem(Pawn Other)
{
	return true;
}
// Chance to do something after Inventory has been loaded
static function PostApply(Pawn Other)
{
}
// Remove the effects of this type of item.
// If this added inventory, no need to do anything here, the inventory should be gone already.
static function ResetPlayer(Pawn Other)
{
}
// Shortcut for adding bonus ammo. This is called if bBonusAmmo == true.
static function bool AddAmmoBonus(Pawn Other, out float AmmoBonus)
{
	return false;
}

defaultproperties
{
     ItemName="DefaultItem"
     ItemAmount="0.0"
     Description="Default Item|Does shit all..."
     Size=10
}
