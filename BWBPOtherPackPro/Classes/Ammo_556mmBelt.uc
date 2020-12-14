//=============================================================================
// Ammo_556mmBelt.
//
// 5.56mm Rounds on belts for machineguns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_556mmBelt extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=170
     InitialAmount=85
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPOtherPackPro.AP_M575Belt'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=256,X2=319,Y2=63)
     ItemName="5.56mm Guardian Belt Ammo"
}
