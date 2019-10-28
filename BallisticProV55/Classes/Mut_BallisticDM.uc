//=============================================================================
// Mut_BallisticDM.
//
// The internal ballistic deathmatch subclass of Ballistic Swap mutator.
// This is added to the game by gameinfo and is not available in mutator lists.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_BallisticDM extends Mut_BallisticSwap
	HideDropDown
	CacheExempt;

function bool MutatorIsAllowed()
{
	return true;
}

defaultproperties
{
     DMMode=True
     FriendlyName="Ballistic - Internal"
}
