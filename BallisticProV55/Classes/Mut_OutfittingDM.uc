//=============================================================================
// Mut_OutfittingDM.
//
// The internal ballistic deathmatch subclass of Ballistic Loadout mutator.
// This is added to the game by gameinfo and is not available in mutator lists.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_OutfittingDM extends Mut_Outfitting
	HideDropDown
	CacheExempt;

function bool MutatorIsAllowed()
{
	return true;
}

defaultproperties
{
     DMMode=True
     FriendlyName="Ballistic LoadOut - Internal"
}
