//=============================================================================
// Ammo_FlamerGas.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_FlamerGas extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=80
     InitialAmount=40
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_FlameTankFlash'
     PickupClass=Class'BallisticProV55.AP_FlamerGas'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIcon_FlameTank'
     IconCoords=(X2=63,Y2=63)
     ItemName="Flamer fuel"
     bNoPackResupply=True
}
