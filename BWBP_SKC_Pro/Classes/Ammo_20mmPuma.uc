//=============================================================================
// Ammo_20mmPuma.
//
// 20mm power cells for the PUMA
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_20mmPuma extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=48
     InitialAmount=16
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_12GaugeFlash'
     PickupClass=Class'BWBP_SKC_Pro.AP_PumaCells'
     IconMaterial=Texture'BWBP_SKC_Tex.M1014.AmmoIcon_10GaugeDartBox'
     IconCoords=(X2=63,Y2=63)
     ItemName="20mm PUMA Power Cells"
}
