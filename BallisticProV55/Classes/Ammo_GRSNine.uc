//=============================================================================
// Ammo_GRSNine.
//
// 9mm Low Velocity Pistol bullets for the GRS9.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_GRSNine extends BallisticAmmo;

defaultproperties
{
     InitialAmount=90
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClipsFlash'
     PickupClass=Class'BallisticProV55.AP_GRS9Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClips'
     IconCoords=(X2=64,Y2=64)
     ItemName="9mm JHP Bullets"
}
