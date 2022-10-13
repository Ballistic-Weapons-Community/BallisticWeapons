//=============================================================================
// Mut_Ballistic.
//
// Replaces normal weapons with Ballistic ones
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_BallisticGlobal extends Mutator 
	config(BallisticProV55);

var()		globalconfig string				InventoryModes[6];		// The Mutator Names
var()		globalconfig string				InventoryMuts[6];		// The Summoned Mutators
var()		globalconfig int 				InventoryModeIndex;		// The Setting of mutators

simulated function PreBeginPlay()
{
	Level.Game.AddMutator(InventoryMuts[InventoryModeIndex], false);
}

defaultproperties
{
     InventoryModeIndex=1
	 InventoryModes(0)="Pickups"
     InventoryModes(1)="Outfitting"
     InventoryModes(2)="Conflict"
	 InventoryModes(3)="Evolution"
     InventoryModes(4)="Arena"
	 InventoryModes(5)="Melee Only"
     InventoryMuts(0)="BallisticProV55.Mut_BallisticSwap"
     InventoryMuts(1)="BallisticProV55.Mut_TeamOutfitting"
     InventoryMuts(2)="BallisticProV55.Mut_ConflictLoadout"
	 InventoryMuts(3)="BallisticProV55.Mut_Loadout"
     InventoryMuts(4)="BallisticProV55.Mut_BallisticArena"
	 InventoryMuts(5)="BallisticProV55.Mut_BallisticMelee"
	 ConfigMenuClassName="BallisticProV55.BallisticConfigMenuPro"
     FriendlyName="BallisticPro: Weapons"
     Description="Replaces all the original weapons and items in the game with new, realistic Ballistic weapons and items. Adds reloading, fire modes, special weapon functions, real accuracy, realistic damage, special features like laser sights and tactical cameras, new effects and much much more...||http://www.runestorm.com"
}
