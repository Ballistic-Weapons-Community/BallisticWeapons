//=============================================================================
// Ammo_Pineapple.
//
// Ammo for the NRP57
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_Pineapple extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=2
     InitialAmount=1
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BallisticProV55.NRP57Pickup'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(Y1=64,X2=63,Y2=127)
     ItemName="NRP57 Pineapple Ammo"

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
