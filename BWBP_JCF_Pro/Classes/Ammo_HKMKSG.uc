//=============================================================================
// Ammo_16GuageleMat.
//
// 16 Guage shotgun ammo. Used by Wilson DB revolver.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_HKMKSG extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=24
     InitialAmount=12
     IconFlashMaterial=Shader'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DBFlash'
     PickupClass=Class'BWBP_JCF_Pro.AP_HKMKSG'
     IconMaterial=Texture'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DB'
     IconCoords=(X2=63,Y2=63)
     ItemName="12 Gauge Magnum Shells"
}
