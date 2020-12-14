//=============================================================================
// Ammo_44Magnum.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_44MagnumScope extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=70
     InitialAmount=35
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconPageV2Flash'
     PickupClass=Class'BWBPRecolorsPro.AP_6MagnumScope'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPageV2'
     IconCoords=(X2=63,Y2=63)
     ItemName=".44 Magnum Bullets"
}
