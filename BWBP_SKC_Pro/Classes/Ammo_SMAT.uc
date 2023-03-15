//=============================================================================
// Ammo_SMAT.
//
// Ammo for the SMAA launcher
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SMAT extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=6
     InitialAmount=2
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_SKC_Pro.AP_SMATAmmo'
     //IconMaterial=Texture'BWBP_SKC_TexExp.SMAA.AmmoIcon_SMAT'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
}
