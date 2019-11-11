//=============================================================================
// Ammo_8GuageHE.
//
// 8 Guage HE shotgun ammo. Used by SK410
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_8GaugeHE extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=60
	 InitialAmount=30
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.SK410.AmmoIcon_SK410Flash'
     PickupClass=Class'BWBPRecolorsPro.AP_8Gauge'
     IconMaterial=Texture'BallisticRecolors3TexPro.SK410.AmmoIcon_SK410'
     ItemName="8 Gauge HE Shells"
}
