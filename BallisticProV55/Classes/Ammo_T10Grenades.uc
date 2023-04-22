//=============================================================================
// Ammo_T10Grenades.
//
// Ammo for the T10
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_T10Grenades extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=2
	InitialAmount=1
	IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconPageV2Flash'
	PickupClass=Class'BallisticProV55.T10Pickup'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPageV2'
	IconCoords=(X1=64,X2=127,Y2=63)
	ItemName="T10 Grenade Ammo"

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
