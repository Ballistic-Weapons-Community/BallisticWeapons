//=============================================================================
// Ammo_SMAT.
//
// Ammo for the SMAA launcher
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_SMAT extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=6
	InitialAmount=2
	IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
	PickupClass=Class'BWBP_SKC_Pro.AP_SMATAmmo'
	//IconMaterial=Texture'BWBP_SKC_Tex.SMAA.AmmoIcon_SMAT'
	IconCoords=(X1=128,Y1=64,X2=191,Y2=127)

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.0f
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.0f
	End Object

	Begin Object Class=AmmoParams Name=RealismParams
		KillInitialAmmoMult=0.0f
	End Object

	Begin Object Class=AmmoParams Name=TacticalParams
		KillInitialAmmoMult=0.0f
	End Object

	Params[0]=ArenaParams
	Params[1]=ClassicParams
	Params[2]=RealismParams
	Params[3]=TacticalParams
}
