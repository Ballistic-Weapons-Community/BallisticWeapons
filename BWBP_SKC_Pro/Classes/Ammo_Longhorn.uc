class Ammo_Longhorn extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=32
	InitialAmount=16
	IconFlashMaterial=Shader'BWBP_SKC_Tex.Longhorn.AmmoIcon_LonghornFlash'
	PickupClass=Class'BWBP_SKC_Pro.AP_SMRTGrenade'
	IconMaterial=Texture'BWBP_SKC_Tex.Longhorn.AmmoIcon_Longhorn'
	ItemName="X2 SMRT Grenade"

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.25f
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.25f
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
