//=============================================================================
// Ammo_ICISStim. Stab yourself with fun!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_ICISStim extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=1
     InitialAmount=1
     IconFlashMaterial=Shader'BallisticRecolors4TexPro.Stim.AmmoIcon_StimFlash'
     PickupClass=Class'BWBPRecolorsPro.ICISPickup'
     IconMaterial=Texture'BallisticRecolors4TexPro.Stim.AmmoIcon_Stim'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
     ItemName="ICIS Stim Ammo"
}
