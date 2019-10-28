//=============================================================================
// Ammo_LS14Rocket
//
// Ammo for Carbine's rocket launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_LS14Rocket extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=9
     InitialAmount=3
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPRecolorsPro.AP_LS14Rockets'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="LS14 Rockets"
}
