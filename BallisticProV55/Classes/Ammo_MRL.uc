//=============================================================================
// Ammo_MRL.
//
// Ammo for the MRL
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MRL extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=108
	InitialAmount=54
	IconFlashMaterial=Shader'BW_Core_WeaponTex.MRL.AmmoIcon_MRLRocketsFlash'
	PickupClass=Class'BallisticProV55.AP_MRLRockets'
	IconMaterial=Texture'BW_Core_WeaponTex.MRL.AmmoIcon_MRLRockets'
	IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
	ItemName="MRL Rockets"

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
