//=============================================================================
// Ammo_NovaCrystal.
//
// Ammo for NovaStaff
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_NovaCrystal extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=144
     InitialAmount=72
     IconFlashMaterial=Shader'BWBP4-Tex.NovaStaff.AmmoIcon_NovaCrystalFlash'
     PickupClass=Class'BallisticProV55.AP_NovaCrystal'
     IconMaterial=Texture'BWBP4-Tex.NovaStaff.AmmoIcon_NovaCrystal'
     IconCoords=(X2=63,Y2=63)
     ItemName="Nova Crystal"
}
