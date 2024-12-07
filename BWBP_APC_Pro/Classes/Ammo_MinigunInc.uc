//=============================================================================
// Ammo_MinigunINC.
//
// Incendiary Rounds for XMB-500 minigun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MinigunINC extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=1600
     InitialAmount=400
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_MinigunFlash'
     PickupClass=Class'BWBP_APC_Pro.AP_XMV500Ammo'
     IconMaterial=Texture'BWBP_APC_Tex.XMV500.AmmoIcon_MinigunInc'
     IconCoords=(X2=63,Y2=63)
     ItemName="7.62mm Incendiary Minigun Rounds"
}
