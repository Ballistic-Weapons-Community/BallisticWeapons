//=============================================================================
// Ammo_CX61.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_CX61Rounds extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=192
     InitialAmount=96
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPOtherPackPro.AP_CX61Mag'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="CX61 Flechette Rounds"
}
