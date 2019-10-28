//=============================================================================
// Ammo_RPG.
//
// Ammo for the G5 RPG launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_RPG extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=2
     InitialAmount=2
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_G5Ammo'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
     ItemName="G5 Rockets"
}
