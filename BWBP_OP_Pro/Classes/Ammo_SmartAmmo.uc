//=============================================================================
// Ammo_SmartAmmo.
//
// Smart Ammo used by the FC-01 PDW
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SmartAmmo extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=150
     InitialAmount=50
     IconFlashMaterial=Shader'BWBP_SKC_Tex.CYLO.AmmoIcon_CYLOFlash'
     PickupClass=Class'BWBP_OP_Pro.AP_SmartAmmo'
     IconMaterial=Texture'BWBP_SKC_Tex.CYLO.AmmoIcon_CYLO'
     IconCoords=(X2=64,Y2=64)
     ItemName="5.7mm Smart Ammo"
}
