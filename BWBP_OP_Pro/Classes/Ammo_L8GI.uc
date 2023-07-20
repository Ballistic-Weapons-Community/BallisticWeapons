//=============================================================================
// Ammo_Pineapple.
//
// Ammo for the NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_L8GI extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=1
	InitialAmount=1
	IconFlashMaterial=Shader'BWBP_OP_Tex.AmmoPack.AmmoIcon_AmmoPackFlash'
	PickupClass=Class'BWBP_OP_Pro.L8GIPickup'
	IconMaterial=Texture'BWBP_OP_Tex.AmmoPack.AmmoIcon_AmmoPack'
	IconCoords=(Y1=64,X2=63,Y2=127)
	ItemName="L8 GI Ammo Pack"

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
	End Object

	Begin Object Class=AmmoParams Name=RealismParams
		KillInitialAmmoMult=0.0f
		bResuppliesFromPack=False
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
