//=============================================================================
// Ammo_Laser.
//
// PEW PEW LAZOR.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_Laser extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=200
     InitialAmount=80
     bTryHeadShot=True
     IconFlashMaterial=Shader'BWBP_SKC_Tex.LS14.AmmoIcon_LS14Flash'
     PickupClass=Class'BWBP_SKC_Pro.AP_Laser'
     IconMaterial=Texture'BWBP_SKC_Tex.LS14.AmmoIcon_LS14'
     IconCoords=(X1=64,Y1=64,X2=127,Y2=127)
     ItemName="XM Energy Cells"
}
