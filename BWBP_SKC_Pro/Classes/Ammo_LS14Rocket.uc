//=============================================================================
// Ammo_LS14Rocket
//
// Ammo for Carbine's rocket launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_LS14Rocket extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=9
     InitialAmount=3
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_SKC_Pro.AP_LS14Rockets'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="LS14 Rockets"
}
