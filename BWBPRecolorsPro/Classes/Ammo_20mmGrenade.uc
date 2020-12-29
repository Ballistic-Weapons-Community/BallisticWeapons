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
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.Bulldog.AmmoIcon_FRAGFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_Frag12Box'
     IconMaterial=Texture'BallisticRecolors3TexPro.Bulldog.AmmoIcon_FRAG'
     IconCoords=(X2=64,Y2=64)
     ItemName="FRAG-12 Grenades"
}
