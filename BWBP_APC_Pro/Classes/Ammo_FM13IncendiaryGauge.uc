//=============================================================================
// Ammo_12Gauge.
//
// 12 Gauge shotgun ammo. Used by archon shotguns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_FM13IncendiaryGauge extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=36
     InitialAmount=12
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_12GaugeFlash'
     PickupClass=Class'BWBP_APC_Pro.AP_FM13Box'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIcon_12GaugeBox'
     IconCoords=(X2=63,Y2=63)
     ItemName="12 Gauge INC Shells"
}
