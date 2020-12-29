//=============================================================================
// Ammo_50HV.
//
// .50 Calibre High Velocity Pistol bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_50HV extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=48
     InitialAmount=24
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_AM67Flash'
     PickupClass=Class'BallisticProV55.AP_AM67Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIcon_AM67'
     IconCoords=(X2=63,Y2=63)
     ItemName=".50 High Velocity Bullets"
}
