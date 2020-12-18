//=============================================================================
// Ammo_348Rifle.
//
// .348 caliber high velocity rifle rounds for the R9.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_348Rifle extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=72
     InitialAmount=36
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticTextures3.ui.AmmoIcon_R9ClipsFlash'
     PickupClass=Class'BallisticProV55.AP_R9Clip'
     IconMaterial=Texture'BallisticTextures3.ui.AmmoIcon_R9Clips'
     IconCoords=(X1=64,Y1=64,X2=127,Y2=127)
     ItemName=".348 Rifle Rounds"
}
