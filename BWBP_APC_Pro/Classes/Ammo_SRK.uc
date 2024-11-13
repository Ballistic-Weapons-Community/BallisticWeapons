//=============================================================================
// Ammo_SRK
//
// .45 Calibre High Velocity Pistol bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SRK extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=144
     InitialAmount=72
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_M806Flash'
     PickupClass=Class'BallisticProV55.AP_M806Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIcon_M806'
     IconCoords=(X2=64,Y2=64)
     ItemName=".45 High Velocity Bullets"
}