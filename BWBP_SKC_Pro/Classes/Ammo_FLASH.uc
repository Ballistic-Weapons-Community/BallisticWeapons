//=============================================================================
// Ammo_FLASH.
//=============================================================================
class Ammo_FLASH extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=4
     InitialAmount=4
     IconFlashMaterial=Shader'BWBP_SKC_Tex.Flash.AmmoIcon_FlashFlash'
     PickupClass=Class'BWBP_SKC_Pro.AP_FLASHAmmo'
     IconMaterial=Texture'BWBP_SKC_Tex.Flash.AmmoIcon_FLASH'
     IconCoords=(X1=128,Y1=64,X2=191,Y2=127)

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.0f
	End Object

	Begin Object Class=AmmoParams Name=RealismParams
		KillInitialAmmoMult=0.0f
	End Object

	Begin Object Class=AmmoParams Name=TacticalParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Params[0]=ArenaParams
	Params[1]=ClassicParams
	Params[2]=RealismParams
	Params[3]=TacticalParams
}
