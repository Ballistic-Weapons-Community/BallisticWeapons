//=============================================================================
// Super 12 - M290 ammo.
//=============================================================================
class Ammo_Super12Gauge extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=18
	InitialAmount=18
	IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIcon_12GaugeFlash'
	PickupClass=Class'BallisticProV55.AP_12GaugeBox'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIcon_12GaugeBox'
	IconCoords=(X2=63,Y2=63)
	ItemName="Super 12 Gauge Shells"

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
