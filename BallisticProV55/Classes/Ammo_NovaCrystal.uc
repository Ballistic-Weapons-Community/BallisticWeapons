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
     MaxAmmo=192
     InitialAmount=96
     IconFlashMaterial=Shader'BW_Core_WeaponTex.NovaStaff.AmmoIcon_NovaCrystalFlash'
     PickupClass=Class'BallisticProV55.AP_NovaCrystal'
     IconMaterial=Texture'BW_Core_WeaponTex.NovaStaff.AmmoIcon_NovaCrystal'
     IconCoords=(X2=63,Y2=63)
     ItemName="Nova Crystal"
}
