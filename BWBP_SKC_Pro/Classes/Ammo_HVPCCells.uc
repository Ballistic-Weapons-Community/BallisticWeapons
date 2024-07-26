//=============================================================================
// Ammo_HVCCells.
//
// Ammo for the Nexron plasma cannons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_HVPCCells extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=250
     InitialAmount=100
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_LGFlash'
     PickupClass=Class'BWBP_SKC_Pro.AP_HVPCMk5Cell'
     IconMaterial=Texture'BWBP_SKC_Tex.XavPlasCannon.AmmoIconXav'
     IconCoords=(X2=63,Y2=63)
     ItemName="E-115 Plasma Cells"
}
