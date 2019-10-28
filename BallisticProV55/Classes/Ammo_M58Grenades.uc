//=============================================================================
// Ammo_M58Grenades.
//
// Ammo for the M58
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_M58Grenades extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=2
     InitialAmount=2
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconPageV2Flash'
     PickupClass=Class'BallisticProV55.M58Pickup'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPageV2'
     IconCoords=(X1=64,X2=127,Y2=63)
     ItemName="M58 Grenade Ammo"
}
