//=============================================================================
// Ammo_44Magnum.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_44Magnum extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=72
     InitialAmount=36
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIconPageV2Flash'
     PickupClass=Class'BallisticProV55.AP_6Magnum'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIconPageV2'
     IconCoords=(X2=63,Y2=63)
     ItemName=".44 Magnum Bullets"
}
