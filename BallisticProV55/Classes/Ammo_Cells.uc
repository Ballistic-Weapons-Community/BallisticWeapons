//=============================================================================
// Ammo_Cells.
//
// Ammo for the A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_Cells extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=192
     InitialAmount=96
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_A73Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=256,Y1=64,X2=319,Y2=127)
     ItemName="Skrith Cell Ammo"
}
