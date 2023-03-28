//=============================================================================
// Ammo_Pineapple.
//
// Ammo for the NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_L8GI extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
	 MaxAmmo=1
     InitialAmount=1
     IconFlashMaterial=Shader'BWBP_OP_Tex.AmmoPack.AmmoIcon_AmmoPackFlash'
     PickupClass=Class'BWBP_OP_Pro.L8GIPickup'
     IconMaterial=Texture'BWBP_OP_Tex.AmmoPack.AmmoIcon_AmmoPack'
     IconCoords=(Y1=64,X2=63,Y2=127)
     ItemName="L8 GI Ammo Pack"
}
