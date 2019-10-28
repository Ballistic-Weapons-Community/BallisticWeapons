//=============================================================================
// Melee_A73SkrithRifle.
//
// The A73 for melee only mode
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Melee_A73SkrithRifle extends A73SkrithRifle HideDropDown CacheExempt;

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.8;
	return 0.4 + 0.6 * (AIController(Instigator.Controller).Skill / 7);
}

defaultproperties
{
     FireModeClass(0)=Class'BallisticProV55.A73MeleeFire'
     Priority=7
     PickupClass=Class'BallisticProV55.Melee_A73Pickup'
     AttachmentClass=Class'BallisticProV55.Melee_A73Attachment'
     ItemName="Unfireable A73 Skrith Rifle"
}
