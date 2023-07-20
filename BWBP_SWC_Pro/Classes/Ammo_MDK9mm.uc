//=============================================================================
// Ammo_9mm.
//
// 9mm pistol ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MDK9mm extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=156
     InitialAmount=78
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_SWC_Pro.AP_MDKClip'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=384,Y1=64,X2=447,Y2=127)
     ItemName="9mm Ammo"
}
