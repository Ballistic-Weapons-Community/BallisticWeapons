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
     MaxAmmo=192
     InitialAmount=96
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.CYLO.AmmoIcon_CYLOFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_CYLOInc'
     IconMaterial=Texture'BallisticRecolors3TexPro.CYLO.AmmoIcon_CYLOInc'
     IconCoords=(X2=64,Y2=64)
     ItemName="7.62mm Incendiary Ammo"
}
