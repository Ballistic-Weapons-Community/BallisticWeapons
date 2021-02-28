//=============================================================================
// Ammo_42HVG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_42HVG extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=100
     InitialAmount=40
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_SKC_Pro.AP_42MachineGun'
     IconMaterial=Texture'BWBP_SKC_Tex.M30A2.AmmoIcon_M30A2'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="7.62 Gauss Rounds"
}
