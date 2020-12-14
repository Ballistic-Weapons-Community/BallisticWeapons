//=============================================================================
// Ammo_75BOLT.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_75BOLT extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=32
     InitialAmount=16
     bTryHeadShot=True
     IconFlashMaterial=Shader'BWBP_SKC_Tex.Bulldog.AmmoIcon_BOLTFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_75BOLTClip'
     IconMaterial=Texture'BWBP_SKC_Tex.Bulldog.AmmoIcon_BOLT'
     IconCoords=(X2=64,Y2=64)
     ItemName=".75 BOLT slugs"
}
