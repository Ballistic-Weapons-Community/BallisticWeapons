//=============================================================================
// Ammo_RS8Bullets.
//
// 10mm pistol ammo. Used by the RS8
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SX45Bullets extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=108
     InitialAmount=54
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_BP1Flash'
     PickupClass=Class'BWBP_SKCExp_Pro.AP_SX45Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.ui.RS-AmmoIconPage'
     IconCoords=(X1=64,X2=127,Y2=63)
     ItemName="10mm SX45 Ammo"
}
