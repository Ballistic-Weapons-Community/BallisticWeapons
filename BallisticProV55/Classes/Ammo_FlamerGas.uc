//=============================================================================
// Ammo_FlamerGas.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_FlamerGas extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=50
     InitialAmount=50
     IconFlashMaterial=Shader'BallisticUI2.Icons.AmmoIcon_FlameTankFlash'
     PickupClass=Class'BallisticProV55.AP_FlamerGas'
     IconMaterial=Texture'BallisticUI2.Icons.AmmoIcon_FlameTank'
     IconCoords=(X2=63,Y2=63)
     ItemName="Flamer fuel"
}
