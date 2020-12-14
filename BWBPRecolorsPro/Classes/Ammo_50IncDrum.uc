//=============================================================================
// Ammo_50Inc.
//
// 50 cal incendiary rounds
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_50IncDrum extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=80
     IconFlashMaterial=Shader'BWBP_SKC_TexExp.FG50.AmmoIcon_FG50Flash'
     PickupClass=Class'BWBPRecolorsPro.AP_50IncDrum'
     IconMaterial=Texture'BWBP_SKC_TexExp.FG50.AmmoIcon_FG50'
     IconCoords=(X2=64,Y2=64)
     ItemName=".50 Incendiary Ammo"
}
