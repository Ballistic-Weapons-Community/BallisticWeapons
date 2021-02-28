//=============================================================================
// Ammo_RS8Bullets.
//
// 10mm pistol ammo. Used by the RS8
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SRXBullets extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=60
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_BP1Flash'
     PickupClass=Class'BWBP_SKC_Pro.AP_SRXClip'
     IconMaterial=Texture'BW_Core_WeaponTex.ui.RS-AmmoIconPage'
     IconCoords=(X1=64,X2=127,Y2=63)
     ItemName="10mm SX45 Ammo"
}
