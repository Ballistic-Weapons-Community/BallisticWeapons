//=============================================================================
// Ammo_BX5Mines.
//
// Ammo for the BX5 Mine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_BX5Mines extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
     MaxAmmo=2
     InitialAmount=2
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.BX5Pickup'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=319,Y1=64,X2=383,Y2=127)
     ItemName="BX5 Ammo"
}
