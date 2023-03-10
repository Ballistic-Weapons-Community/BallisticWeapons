//=============================================================================
// Ammo_762mmBelt.
//
// 7.62mm Rounds on belts for machineguns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_762mmBelt extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=150
     InitialAmount=50
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_OP_Pro.AP_M575Belt'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=256,X2=319,Y2=63)
     ItemName="7.62mm Belt Ammo"
}
