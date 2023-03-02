//=============================================================================
// Ammo_CYLO.
//
// 7.62mm Caseless Ammo. Used by CYLO.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_Proto extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=200
     InitialAmount=100
     IconFlashMaterial=Shader'BWBP_SKC_Tex.CYLO.AmmoIcon_CYLOFlash'
     PickupClass=Class'BWBP_APC_Pro.AP_ProtoClip'
     IconMaterial=Texture'BWBP_SKC_Tex.CYLO.AmmoIcon_CYLO'
     IconCoords=(X2=64,Y2=64)
     ItemName="5.56mm Caseless Ammo"
}
