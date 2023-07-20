//=============================================================================
// Conqueror ammo type.
//=============================================================================
class Ammo_HB4 extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=15
     InitialAmount=9
     IconFlashMaterial=Shader'BWBP_CC_Tex.HoloBlaster.AmmoIcon_HoloBlasterFlash'
     PickupClass=Class'BWBP_APC_Pro.AP_HB4Batteries'
     IconMaterial=Texture'BWBP_CC_Tex.HoloBlaster.AmmoIcon_HoloBlaster'
     IconCoords=(X2=64,Y2=64)
     ItemName="HB4 Battery Packs"

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
