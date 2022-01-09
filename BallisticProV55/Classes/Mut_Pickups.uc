//=============================================================================
// Mut_Pickups.
//
// by Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class Mut_Pickups extends Mutator 
	HideDropDown 
	CacheExempt 
	config(BallisticProV55);

var globalconfig bool bRemoveAmmoPacks; 		// ammo packs
var globalconfig bool bRemoveUDamage; 			// damage amplifier
var globalconfig bool bRemoveShieldPack; 		// small armor
var globalconfig bool bRemoveSuperShieldPack; 	// big armor
var globalconfig bool bRemoveBandages; 			// bandages
var globalconfig bool bRemoveHealthPack; 		// health pack
var globalconfig bool bRemoveSuperHealthPack; 	// super health pack
var globalconfig bool bRemoveAdrenaline; 		// adrenaline
var globalconfig bool bAnimatedPickups;			// Press Use to Pickup

simulated function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
    local bool bRes;

    bRes = Super.CheckReplacement(Other, bSuperRelevant);

    if (bRemoveAmmoPacks && Other.IsA('IP_AmmoPack')) // ammo packs
        bRes = false;

    else if (bRemoveBandages && (Other.IsA('IP_Bandage') || Other.IsA('MiniHealthPack'))) // bandages
        bRes = false;

    else if (bRemoveSuperShieldPack && (Other.IsA('IP_BigArmor') || Other.IsA('SuperShieldPack'))) // big armor
        bRes = false;

    else if (bRemoveShieldPack && (Other.IsA('IP_SmallArmor') || Other.IsA('ShieldPack'))) // small armor
        bRes = false;

    else if (bRemoveUDamage && (Other.IsA('IP_UDamage') || Other.IsA('UDamagePack'))) // damage amplifier
        bRes = false;

    else if (bRemoveAdrenaline && (Other.IsA('AdrenalinePickup') || Other.IsA('IP_Adrenaline'))) // adrenaline
        bRes = false;

    else if (bRemoveHealthPack && (Other.IsA('HealthPack') || Other.IsA('IP_HealthKit'))) // Health kit
        bRes = false;

    else if (bRemoveSuperHealthPack && (Other.IsA('SuperHealthPack') || Other.IsA('IP_SuperHealthKit'))) // Super health kit
        bRes = false;

    return bRes;
}

defaultproperties
{
     bRemoveAmmoPacks=False
     bRemoveUDamage=False
     bRemoveShieldPack=False
     bRemoveSuperShieldPack=False
     bRemoveBandages=False
     bRemoveHealthPack=False
     bRemoveSuperHealthPack=False
     bRemoveAdrenaline=False
     bAnimatedPickups=False
     bAddToServerPackages=False
     FriendlyName="BallisticPro - Equipment"
     Description="BallisticPro - Equipment - Internal"
     RemoteRole=ROLE_SimulatedProxy
}
