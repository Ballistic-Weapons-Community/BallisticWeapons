//=============================================================================
// Ammo_Laser.
//
// PEW PEW LAZOR.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_ThumperGrenades extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=45
	InitialAmount=15
	IconFlashMaterial=Shader'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGPFlash'
	PickupClass=Class'BWBP_SKC_Pro.AP_ThumperGrenades'
	IconMaterial=Texture'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGP'
	IconCoords=(X2=64,Y2=64)
	ItemName="35mm Caseless Grenades"

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
