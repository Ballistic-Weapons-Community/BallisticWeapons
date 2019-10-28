//=============================================================================
// Ammo_CYLO.
//
// 7.62mm Caseless Ammo. Used by CYLO.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_CYLO extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=168
     InitialAmount=84
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.CYLO.AmmoIcon_CYLOFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_CYLOClip'
     IconMaterial=Texture'BallisticRecolors3TexPro.CYLO.AmmoIcon_CYLO'
     IconCoords=(X2=64,Y2=64)
     ItemName="7.62mm Caseless Ammo"
}
