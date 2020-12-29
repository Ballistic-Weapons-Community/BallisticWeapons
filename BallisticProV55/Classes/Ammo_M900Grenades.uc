//=============================================================================
// Ammo_M900Grenades.
//
// Ammo for the M900 Grenade launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_M900Grenades extends BallisticAmmo;

var   M50AssaultRifle		DaM50;

function bool HandlePickupQuery(Pickup Item)
{
	if (Super.HandlePickupQuery(Item))
	{
		if (DaM50 != None)
			DaM50.GrenadePickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=4
     InitialAmount=2
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_M900Grenades'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="M900 Grenades"
}
