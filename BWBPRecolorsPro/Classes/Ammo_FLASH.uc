//=============================================================================
// Ammo_FLASH.
//=============================================================================
class Ammo_FLASH extends BallisticAmmo;

defaultproperties
{
     bNoPackResupply=True
     MaxAmmo=4
     InitialAmount=4
     IconFlashMaterial=Shader'BWBP_SKC_TexExp.Flash.AmmoIcon_FlashFlash'
     PickupClass=Class'BWBPRecolorsPro.AP_FLASHAmmo'
     IconMaterial=Texture'BWBP_SKC_TexExp.Flash.AmmoIcon_FLASH'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
}
