//=============================================================================
// Ammo_42Rifle.
//
// .42 Calibre super high velocity Rifle rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_50BMG extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=30
     InitialAmount=15
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPRecolorsPro.AP_50BMGClip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=64,Y1=64,X2=127,Y2=127)
     ItemName=".50 N6-BMG HEAP Rifle Rounds"
}
