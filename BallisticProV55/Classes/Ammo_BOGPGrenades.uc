//=============================================================================
// Ammo_BOGPGrenades.
//
// Ammo for the BOGP Grenade launcher
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_BOGPGrenades extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=20
     InitialAmount=10
     IconFlashMaterial=Shader'BallisticTextures_25.BOGP.AmmoIcon_BOGPFlash'
     PickupClass=Class'BallisticProV55.AP_BOGPGrenades'
     IconMaterial=Texture'BallisticTextures_25.BOGP.AmmoIcon_BOGP'
     IconCoords=(X2=64,Y2=64)
     ItemName="BORT-85 Grenades"
}
