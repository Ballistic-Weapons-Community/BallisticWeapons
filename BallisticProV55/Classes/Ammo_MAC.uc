//=============================================================================
// Ammo_MAC.
//
// Ammo for the HAMR
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_MAC extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=5
	InitialAmount=5
	IconFlashMaterial=Shader'BW_Core_WeaponTex.Artillery.AmmoIcon_ArtilleryShellsFlash'
	PickupClass=Class'BallisticProV55.AP_MACShells'
	IconMaterial=Texture'BW_Core_WeaponTex.Artillery.AmmoIcon_ArtilleryShells'
	IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
	ItemName="HAMR Shells"

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
