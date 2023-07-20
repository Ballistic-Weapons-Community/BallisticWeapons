//=============================================================================
// Ammo_GASCClip.
//
// .45 Calibre High Velocity Pistol bullets.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_GASCClip extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=160
     InitialAmount=80
     IconFlashMaterial=Shader'BW_Core_WeaponTex.MD24.AmmoIcon_MD24Flash'
     PickupClass=Class'BWBP_APC_Pro.AP_GASCClip'
     IconMaterial=Texture'BW_Core_WeaponTex.MD24.AmmoIcon_MD24'
     IconCoords=(X2=64,Y2=64)
     ItemName="9mm super Gaucho Bullets"
}
