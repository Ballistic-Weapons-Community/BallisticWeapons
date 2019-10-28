//=============================================================================
// Ammo_75BOLT.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_75BOLT extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=36
     InitialAmount=18
     bTryHeadShot=True
     IconFlashMaterial=Shader'BallisticRecolors3TexPro.Bulldog.AmmoIcon_BOLTFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_75BOLTClip'
     IconMaterial=Texture'BallisticRecolors3TexPro.Bulldog.AmmoIcon_BOLT'
     IconCoords=(X2=64,Y2=64)
     ItemName=".75 BOLT slugs"
}
