//=============================================================================
// Ammo_Pineapple.
//
// Ammo for the NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_Pineapple extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=2
     InitialAmount=1
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.NRP57Pickup'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(Y1=64,X2=63,Y2=127)
     ItemName="NRP57 Pineapple Ammo"
}
