//=============================================================================
// Ammo_ICISStim. Stab yourself with fun!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_ICISStim extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=100
	InitialAmount=50
	IconFlashMaterial=Shader'BWBP_SKC_Tex.Stim.AmmoIcon_StimFlash'
	PickupClass=Class'BWBP_SKC_Pro.ICISPickup'
	IconMaterial=Texture'BWBP_SKC_Tex.Stim.AmmoIcon_Stim'
	IconCoords=(X1=128,Y1=64,X2=191,Y2=127)
	ItemName="ICIS Stim Ammo"

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
