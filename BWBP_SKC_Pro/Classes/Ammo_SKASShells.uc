//=============================================================================
// Ammo_HVCCells.
//
// Ammo for the Nexron plasma cannons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SKASShells extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=48
     InitialAmount=24
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_BP1Flash'
     PickupClass=Class'BWBP_SKC_Pro.AP_SKASDrum'
     IconMaterial=Texture'BW_Core_WeaponTex.ui.RS-AmmoIconPage'
     IconCoords=(X2=63,Y2=63)
     ItemName="SKAS-21 Shells"
}
