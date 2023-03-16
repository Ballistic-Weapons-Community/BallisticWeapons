//=============================================================================
// Mut_BallisticStyle
//
// Bootstrapper mutator used to set game style information before spawning main 
// Ballistic mutators.
//=============================================================================
class Mut_BallisticStyle extends Mutator 
	abstract
	HideDropDown
	CacheExempt
	config(BallisticProV55);

var BC_GameStyle.EGameStyle		OverrideStyle;

struct InventoryMode
{
	var string Name;
	var string MutatorClassName;
};

var()	InventoryMode		InventoryModes[6];		// The Mutator Names

simulated function PreBeginPlay()
{
	// override the current style before creating the underlying BW mutator
	// the mutator will then use the style to spawn the BallisticReplicationInfo,
	// and thereafter it will be read from there
	class'BallisticGameStyles'.default.CurrentStyle = OverrideStyle;

	Level.Game.AddMutator(InventoryModes[class'BallisticGameStyles'.static.GetLocalStyle().default.InventoryModeIndex].MutatorClassName, false);
}

defaultproperties
{
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
