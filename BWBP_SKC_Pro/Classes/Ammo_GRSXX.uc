//=============================================================================
// Ammo_GRSNine.
//
// 9mm Low Velocity Pistol bullets for the GRS9.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_GRSXX extends BallisticAmmo;

defaultproperties
{
     InitialAmount=90
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClipsFlash'
     PickupClass=Class'BWBP_SKC_Pro.AP_GRSXXClip'
     IconMaterial=Texture'BW_Core_WeaponTex.Glock.AmmoIcon_GlockClips'
     IconCoords=(X2=64,Y2=64)
     ItemName="9mm JHP Bullets"

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
