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

// FUCK. Misunderstood it.

struct InventoryMode
{
	var string Name;
	var string MutatorClassName;
};

var()	InventoryMode		InventoryModes[6];		// The Mutator Names
var()	globalconfig int 	InventoryModeIndex;		// The Setting of mutators

simulated function PreBeginPlay()
{
	Level.Game.AddMutator(InventoryModes[InventoryModeIndex].MutatorClassName, false);
}

defaultproperties
{
     InventoryModeIndex=1
	 InventoryModes(0)=(Name="Pickups",MutatorClassName="BallisticProV55.Mut_BallisticSwap")
	 InventoryModes(1)=(Name="Outfitting",MutatorClassName="BallisticProV55.Mut_Outfitting")
     InventoryModes(2)=(Name="Conflict",MutatorClassName="BallisticProV55.Mut_ConflictLoadout")
	 InventoryModes(3)=(Name="Evolution",MutatorClassName="BallisticProV55.Mut_Loadout")
     InventoryModes(4)=(Name="Arena",MutatorClassName="BallisticProV55.Mut_BallisticArena")
	 InventoryModes(5)=(Name="Melee Only",MutatorClassName="BallisticProV55.Mut_BallisticMelee")
	 ConfigMenuClassName="BallisticProV55.ConfigMenu_Rules"
     FriendlyName="BallisticPro: Weapons"
     Description="Replaces all the original weapons and items in the game with new, realistic Ballistic weapons and items. Adds reloading, fire modes, special weapon functions, real accuracy, realistic damage, special features like laser sights and tactical cameras, new effects and much much more...||http://www.runestorm.com"
}
