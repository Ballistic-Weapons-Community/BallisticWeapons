//=============================================================================
// Ammo_Laser.
//
// PEW PEW LAZOR.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_XM20Laser extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=180
     InitialAmount=120
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.LS14.AmmoIcon_LS14Flash'
     PickupClass=Class'BWBPSomeOtherPack.AP_XM20Laser'
     IconMaterial=Texture'BallisticRecolors3TexPro.LS14.AmmoIcon_LS14'
     IconCoords=(X1=64,Y1=64,X2=127,Y2=127)
     ItemName="XM-20 Energy Cells"
}
