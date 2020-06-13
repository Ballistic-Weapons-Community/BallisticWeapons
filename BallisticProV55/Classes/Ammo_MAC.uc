//=============================================================================
// Ammo_MAC.
//
// Ammo for the HAMR
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MAC extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
     MaxAmmo=4
     InitialAmount=4
     IconFlashMaterial=Shader'BWBP4-Tex.Artillery.AmmoIcon_ArtilleryShellsFlash'
     PickupClass=Class'BallisticProV55.AP_MACShells'
     IconMaterial=Texture'BWBP4-Tex.Artillery.AmmoIcon_ArtilleryShells'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
     ItemName="HAMR Shells"
}
