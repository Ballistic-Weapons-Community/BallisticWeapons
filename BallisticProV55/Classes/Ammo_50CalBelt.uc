//=============================================================================
// Ammo_50CalBelt.
//
// .50 caliber rounds on belts for machineguns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_50CalBelt extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=100
     InitialAmount=50
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_M925Belt'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=384,X2=447,Y2=63)
     ItemName=".50 MG Belt Ammo"
}
