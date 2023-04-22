//=============================================================================
// Ammo_BOGPGrenades.
//
// Ammo for the BOGP Grenade launcher
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_BOGPGrenades extends BallisticAmmo;

defaultproperties
{
     MaxAmmo=20
     InitialAmount=10
     IconFlashMaterial=Shader'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGPFlash'
     PickupClass=Class'BallisticProV55.AP_BOGPGrenades'
     IconMaterial=Texture'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGP'
     IconCoords=(X2=64,Y2=64)
     ItemName="BORT-85 Grenades"

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.4f
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.4f
	End Object

	Begin Object Class=AmmoParams Name=RealismParams
		KillInitialAmmoMult=0.2f
	End Object

	Begin Object Class=AmmoParams Name=TacticalParams
		KillInitialAmmoMult=0.2f
	End Object

	Params[0]=ArenaParams
	Params[1]=ClassicParams
	Params[2]=RealismParams
	Params[3]=TacticalParams
}
