//=============================================================================
// Ammo_556mm.
//
// 5.56mm bullet ammo. Used by several of the ballistic weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MX32Bullets extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=250
     InitialAmount=100
     IconFlashMaterial=Shader'BWBP_OP_Tex.MX32.AmmoIcon_MX32Flash'
     PickupClass=Class'BWBPOtherPackPro.AP_MX32Bullets'
     IconMaterial=Texture'BWBP_OP_Tex.MX32.AmmoIcon-MX32'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="MX-32 Magazine"
}
