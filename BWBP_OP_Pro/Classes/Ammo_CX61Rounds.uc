//=============================================================================
// Ammo_CX61. 14mm darts
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_CX61Rounds extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=192
     InitialAmount=96
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_OP_Pro.AP_CX61Mag'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="CX61 Flechette Rounds"
}
