//=============================================================================
// Ammo_9mm.
//
// 9mm pistol ammo.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_FiftyNine extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=192
     InitialAmount=96
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_XK2Clip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=384,Y1=64,X2=447,Y2=127)
     ItemName="9mm Ammo"
}
