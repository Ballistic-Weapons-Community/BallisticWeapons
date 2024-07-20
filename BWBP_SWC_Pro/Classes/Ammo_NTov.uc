//=============================================================================
// Ammo_Pineapple.
//
// Ammo for the NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_NTov extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=3
     InitialAmount=1
     //IconFlashMaterial=Shader'BWBP_SWC_Tex.NTOV.AmmoIcon_NTovFlash'
     PickupClass=Class'BWBP_SWC_Pro.NTovPickup'
     //IconMaterial=Texture'BWBP_SWC_Tex.NTOV.AmmoIcon_NTOV'
     IconCoords=(Y1=64,X2=63,Y2=127)
     ItemName="N-TOV Bandages"
}
