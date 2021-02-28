//=============================================================================
// Ammo_XM84HTG.
//
// Ammo for the XM84
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_XM84HTG extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=3
     InitialAmount=1
     IconFlashMaterial=Shader'BWBP_SKC_Tex.XM84.AmmoIcon_XM84Flash'
     PickupClass=Class'BWBPRecolorsPro.XM84Pickup'
     IconMaterial=Texture'BWBP_SKC_Tex.XM84.AmmoIcon_XM84'
     IconCoords=(X2=64,Y2=64)
     ItemName="XM84 Tech Grenade Ammo"
}
