//=============================================================================
// Ammo_RPG.
//
// Ammo for the Hydra RPG launcher
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_HRPG extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
	 MaxAmmo=24
     InitialAmount=24
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_APC_Pro.AP_HydraAmmo'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
     ItemName="Hydra Rockets"
}
