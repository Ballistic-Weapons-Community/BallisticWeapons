//=============================================================================
// Ammo_FP7Grenades.
//
// Ammo for the FP7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_FP7Grenades extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=2
     InitialAmount=1
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.FP7Pickup'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X2=63,Y2=63)
     ItemName="FP7 Grenade Ammo"
}
