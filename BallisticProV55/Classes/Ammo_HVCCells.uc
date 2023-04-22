//=============================================================================
// Ammo_HVCCells.
//
// Ammo for the HVC-Mk9 Lightning Gun and stuff like that...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_HVCCells extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=150
	InitialAmount=150
	IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_LGFlash'
	PickupClass=Class'BallisticProV55.AP_HVCMk9Cell'
	IconMaterial=Texture'BW_Core_WeaponTex.Lighter.AmmoIconLG'
	IconCoords=(X2=63,Y2=63)
	ItemName="HVC Lightning Cells"

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
