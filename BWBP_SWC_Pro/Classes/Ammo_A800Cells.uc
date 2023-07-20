//=============================================================================
// Ammo_Cells.
//
// Ammo for the A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_A800Cells extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=360
     InitialAmount=180
     IconFlashMaterial=Shader'BWBP_SWC_Tex.SkrithMinigun.AmmoIcon_SkrithBigCellFlash'
     PickupClass=Class'BallisticProV55.AP_A73Clip'
     IconMaterial=Texture'BWBP_SWC_Tex.SkrithMinigun.AmmoIcon_SkrithBigCell'
     IconCoords=(X1=256,Y1=64,X2=319,Y2=127)
     ItemName="Skrith Heavy Cell Ammo"
}
