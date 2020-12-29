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
     MaxAmmo=12
     InitialAmount=6
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_G5Ammo'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
     ItemName="G5 Rockets"
}
