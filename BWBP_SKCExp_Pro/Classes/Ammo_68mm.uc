//=============================================================================
// Ammo_68mm.
//
// 6.8mm bullet ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_68mm extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=150
     InitialAmount=100
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_SKCExp_Pro.AP_556mmClip'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="6.8mm HVHE ammo"
}
