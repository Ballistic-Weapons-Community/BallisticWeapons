//=============================================================================
// Ammo_CYLO.
//
// 7.62mm Caseless Ammo. Used by CYLO.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_ZX98 extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=80
     IconFlashMaterial=Shader'BWBP_APC_Tex.AR.ARAmmoIconFlash'
     PickupClass=Class'BWBP_APC_Pro.AP_ZX98Clip'
     IconMaterial=Texture'BWBP_APC_Tex.AR.ARAmmoIcon'
     IconCoords=(X2=64,Y2=64)
     ItemName="7.62mm Caseless Ammo"
}
