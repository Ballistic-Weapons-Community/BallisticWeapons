//=============================================================================
// Ammo_CYLOINC.
//
// 7.62mm Incendiary Ammo. Used by CYLO Mk2.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_CYLOInc extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=208
     InitialAmount=104
     IconFlashMaterial=Shader'BWBP_SKC_Tex.CYLO.AmmoIcon_CYLOFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_CYLOInc'
     IconMaterial=Texture'BWBP_SKC_Tex.CYLO.AmmoIcon_CYLOInc'
     IconCoords=(X2=64,Y2=64)
     ItemName="7.62mm Incendiary Ammo"
}
