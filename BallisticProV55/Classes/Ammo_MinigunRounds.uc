//=============================================================================
// Ammo_MinigunRounds.
//
// Rounds for XMV850 minigun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MinigunRounds extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=300
     InitialAmount=0
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_MinigunFlash'
     PickupClass=Class'BallisticProV55.AP_XMV850Ammo'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIcon_MinigunBelt'
     IconCoords=(X2=63,Y2=63)
     ItemName="5.56mm Minigun Rounds"
}
