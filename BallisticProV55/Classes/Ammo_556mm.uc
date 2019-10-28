//=============================================================================
// Ammo_556mm.
//
// 5.56mm bullet ammo. Used by several of the ballistic weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_556mm extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=240
     InitialAmount=120
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_556mmClip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="5.56mm Ammo"
}
