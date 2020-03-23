//=============================================================================
// Ammo_42Rifle.
//
// .42 Calibre super high velocity Rifle rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_LightningRifle extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=36
     InitialAmount=18
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticJiffyPack.AP_LightningClip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=64,Y1=64,X2=127,Y2=127)
     ItemName=".42 Rifle Rounds"
}
