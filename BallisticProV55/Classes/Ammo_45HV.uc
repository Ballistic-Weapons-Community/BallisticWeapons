//=============================================================================
// Ammo_45HV.
//
// .45 Calibre High Velocity Pistol bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_45HV extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=42
     InitialAmount=28
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_M806Flash'
     PickupClass=Class'BallisticProV55.AP_M806Clip'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIcon_M806'
     IconCoords=(X2=64,Y2=64)
     ItemName=".45 High Velocity Bullets"
}
