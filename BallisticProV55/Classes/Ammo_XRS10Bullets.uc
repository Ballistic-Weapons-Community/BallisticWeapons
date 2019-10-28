//=============================================================================
// Ammo_XRS10Bullets.
//
// 10mm pistol ammo. Used by the XRS10
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_XRS10Bullets extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=144
     InitialAmount=72
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_BP1Flash'
     PickupClass=Class'BallisticProV55.AP_XRS10Clip'
     IconMaterial=Texture'BWAddPack-RS-Skins.ui.RS-AmmoIconPage'
     IconCoords=(Y1=64,X2=63,Y2=127)
     ItemName=".40 XRS10 Ammo"
}
