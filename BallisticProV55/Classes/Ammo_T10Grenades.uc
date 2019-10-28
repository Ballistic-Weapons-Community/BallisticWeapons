//=============================================================================
// Ammo_T10Grenades.
//
// Ammo for the T10
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_T10Grenades extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=3
     InitialAmount=1
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconPageV2Flash'
     PickupClass=Class'BallisticProV55.T10Pickup'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPageV2'
     IconCoords=(X1=64,X2=127,Y2=63)
     ItemName="T10 Grenade Ammo"
}
