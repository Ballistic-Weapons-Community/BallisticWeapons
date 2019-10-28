//=============================================================================
// Ammo_RS8Bullets.
//
// 10mm pistol ammo. Used by the RS8
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_RS8Bullets extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=60
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_BP1Flash'
     PickupClass=Class'BallisticProV55.AP_RS8Clip'
     IconMaterial=Texture'BWAddPack-RS-Skins.ui.RS-AmmoIconPage'
     IconCoords=(X1=64,X2=127,Y2=63)
     ItemName="10mm RS8 Ammo"
}
