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
     MaxAmmo=1
     InitialAmount=1
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.NRP57Pickup'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(Y1=64,X2=63,Y2=127)
     ItemName="NRP57 Pineapple Ammo"
}
