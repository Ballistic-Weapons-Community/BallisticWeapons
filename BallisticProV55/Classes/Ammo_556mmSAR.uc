//=============================================================================
// Ammo_556mm.
//
// 5.56mm bullet ammo. Used by several of the ballistic weapons. Duplicate exists for the SAR12 ammo count
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_556mmSAR extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=256
     InitialAmount=128
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_556mmClipSAR'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="5.56mm Ammo"
}
