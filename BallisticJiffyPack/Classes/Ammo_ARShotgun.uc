//=============================================================================
// Ammo_8GuageHE.
//
// 8 Guage HE shotgun ammo. Used by SK410
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_ARShotgun extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=120
     InitialAmount=30
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.SK410.AmmoIcon_SK410Flash'
     PickupClass=Class'BallisticJiffyPack.AP_ARShotgun'
     IconMaterial=Texture'BallisticRecolors3TexPro.SK410.AmmoIcon_SK410'
     ItemName="RCS Magazine"
}
