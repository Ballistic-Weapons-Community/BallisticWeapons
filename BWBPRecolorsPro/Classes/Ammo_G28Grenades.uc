//=============================================================================
// Ammo_G28Grenades.
//
// Ammo for the G28
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_G28Grenades extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=4
     InitialAmount=2
     IconFlashMaterial=Shader'BWBP_SKC_Tex.G28.AmmoIcon_MedFlash'
     PickupClass=Class'BWBPRecolorsPro.G28Pickup'
     IconMaterial=Texture'BWBP_SKC_Tex.G28.AmmoIcon_Med'
     IconCoords=(X2=64,Y2=64)
     ItemName="G28 Medicinal Aerosol Ammo"
     bNoPackResupply=True
}
