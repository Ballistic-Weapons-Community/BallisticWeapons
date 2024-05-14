//=============================================================================
// Ammo_AH104Flamer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_AH104Flamer extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=100
	InitialAmount=50
	IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_FlameTankFlash'
	PickupClass=Class'BallisticProV55.AP_FlamerGas'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIcon_FlameTank'
	IconCoords=(X2=63,Y2=63)
	ItemName="AH104 flamer fuel"

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
		KillInitialAmmoMult=0.25f
	End Object

	Params[0]=ArenaParams
	Params[1]=ClassicParams
	Params[2]=RealismParams
	Params[3]=TacticalParams
}
