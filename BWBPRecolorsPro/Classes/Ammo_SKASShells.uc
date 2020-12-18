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
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_BP1Flash'
     PickupClass=Class'BWBPRecolorsPro.AP_SKASDrum'
     IconMaterial=Texture'BWAddPack-RS-Skins.ui.RS-AmmoIconPage'
     IconCoords=(X2=63,Y2=63)
     ItemName="SKAS-21 Shells"
}
