//=============================================================================
// Ammo_G28Grenades.
//
// Ammo for the G28
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_G28Grenades extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=3
	InitialAmount=1
	IconFlashMaterial=Shader'BWBP_SKC_Tex.G28.AmmoIcon_MedFlash'
	PickupClass=Class'BWBP_SKC_Pro.G28Pickup'
	IconMaterial=Texture'BWBP_SKC_Tex.G28.AmmoIcon_Med'
	IconCoords=(X2=64,Y2=64)
	ItemName="G28 Medicinal Aerosol Ammo"

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
