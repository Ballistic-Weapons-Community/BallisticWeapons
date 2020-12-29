//=============================================================================
// Ammo_RS762mm.
//
// 7.62mm bullet ammo. Used by SRS900 Battle Rifle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_762Short extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=150
     InitialAmount=75
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_SRSFlash'
     PickupClass=Class'BallisticProV55.AP_SRS900Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.SRS900.AmmoIcon_SRSClips'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName=".308 Rifle Rounds"
}
