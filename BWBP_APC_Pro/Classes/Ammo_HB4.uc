//=============================================================================
// Conqueror ammo type.
//=============================================================================
class Ammo_HB4 extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=False
     MaxAmmo=15
     InitialAmount=9
     IconFlashMaterial=Shader'BWBP_CC_Tex.HoloBlaster.AmmoIcon_HoloBlasterFlash'
     PickupClass=Class'BWBP_APC_Pro.AP_HB4Batteries'
     IconMaterial=Texture'BWBP_CC_Tex.HoloBlaster.AmmoIcon_HoloBlaster'
     IconCoords=(X2=64,Y2=64)
     ItemName="HB4 Battery Packs"
}
