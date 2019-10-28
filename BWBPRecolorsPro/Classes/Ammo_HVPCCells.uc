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
     bNoPackResupply=True
     MaxAmmo=400
     InitialAmount=200
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_LGFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_HVPCMk5Cell'
     IconMaterial=Texture'BallisticRecolors3TexPro.XavPlasCannon.AmmoIconXav'
     IconCoords=(X2=63,Y2=63)
     ItemName="E-115 Plasma Cells"
}
