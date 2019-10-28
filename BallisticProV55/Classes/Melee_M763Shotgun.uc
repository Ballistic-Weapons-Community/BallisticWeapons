//=============================================================================
// Melee_M763Shotgun.
//
// The M763 Shotgun for melee only mode
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Melee_M763Shotgun extends M763Shotgun HideDropDown CacheExempt;

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	if (AIController(Instigator.Controller) == None)
		return 0.8;
	return 0.4 + 0.6 * (AIController(Instigator.Controller).Skill / 7);
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
    return -0.5;
}

defaultproperties
{
     FireModeClass(0)=Class'BallisticProV55.M763MeleeFire'
     Priority=9
     PickupClass=Class'BallisticProV55.Melee_M763Pickup'
     AttachmentClass=Class'BallisticProV55.Melee_M763Attachment'
     ItemName="Unfireable M763 Shotgun"
}
