//=============================================================================
// Ammo_20mmGrenade
//
// Ammo for the Bulldog Alt Fire
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_20mmGrenade extends BallisticAmmo;

static function int GetKillResupplyAmmo()
{
	return 3;
}

defaultproperties
{
     MaxAmmo=12
     InitialAmount=6
     IconFlashMaterial=Shader'BWBP_SKC_Tex.Bulldog.AmmoIcon_BOLTFlash'
     PickupClass=Class'BWBP_SKC_Pro.AP_Frag12Box'
     IconMaterial=Texture'BWBP_SKC_Tex.Bulldog.AmmoIcon_BOLT'
     IconCoords=(X2=64,Y2=64)
     ItemName="FRAG-12 Grenades"
}
