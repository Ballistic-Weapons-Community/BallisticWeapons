//=============================================================================
// Ammo_42Rifle.
//
// .42 Calibre super high velocity Rifle rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_42Rifle extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=60
     InitialAmount=30
     bTryHeadShot=True
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.AP_R78Clip'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=64,Y1=64,X2=127,Y2=127)
     ItemName=".42 Rifle Rounds"
}
