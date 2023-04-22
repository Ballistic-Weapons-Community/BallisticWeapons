//=============================================================================
// Ammo_LAW.
//
// Ammo for the LAW Launcher. Fires T70B1 Nuclear Shockwave rockets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_LAW extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=2
	InitialAmount=0
	IconFlashMaterial=Shader'BWBP_SKC_Tex.LAW.AmmoIcon_LAWFlash'
	PickupClass=Class'BWBP_SKC_Pro.AP_LAWTube'
	IconMaterial=Texture'BWBP_SKC_Tex.LAW.AmmoIcon_LAW'
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
