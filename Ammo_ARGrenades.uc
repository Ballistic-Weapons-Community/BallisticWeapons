//=============================================================================
// Ammo_M900Grenades.
//
// Ammo for the M900 Grenade launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_ARGrenades extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=12
     InitialAmount=6
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticJiffyPack.AP_ARGrenades'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="RCS Grenades"
}
