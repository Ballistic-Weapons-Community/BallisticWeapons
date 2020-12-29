//=============================================================================
// Ammo_HVCCells.
//
// Ammo for the HVC-Mk9 Lightning Gun and stuff like that...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_HVCCells extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
     MaxAmmo=150
     InitialAmount=150
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_LGFlash'
     PickupClass=Class'BallisticProV55.AP_HVCMk9Cell'
     IconMaterial=Texture'BWBP2-Tex.Lighter.AmmoIconLG'
     IconCoords=(X2=63,Y2=63)
     ItemName="HVC Lightning Cells"
}
