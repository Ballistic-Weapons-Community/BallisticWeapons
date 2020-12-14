//=============================================================================
// Ammo_MD24Clip.
//
// .45 Calibre High Velocity Pistol bullets.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MD24Clip extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=144
     InitialAmount=72
     IconFlashMaterial=Shader'BW_Core_WeaponTex.MD24.AmmoIcon_MD24Flash'
     PickupClass=Class'BallisticProV55.AP_MD24Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.MD24.AmmoIcon_MD24'
     IconCoords=(X2=64,Y2=64)
     ItemName="10mm super MD24 Bullets"
}
