//=============================================================================
// Ammo_E23Cells.
//
// Ammo for the E23 Plasma Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_E23Cells extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=600
     InitialAmount=300
     IconFlashMaterial=Shader'BW_Core_WeaponTex.VPR.AmmoIcon_VPRCellsFlash'
     PickupClass=Class'BallisticProV55.AP_E23Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.VPR.AmmoIcon_VPRCells'
     IconCoords=(X2=63,Y2=63)
     ItemName="E23 ViPeR Cell Ammo"
}
