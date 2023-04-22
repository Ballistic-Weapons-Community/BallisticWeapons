//=============================================================================
// Conqueror ammo type.
//=============================================================================
class Ammo_MGL extends BallisticAmmo;

defaultproperties
{
	MaxAmmo=12
	InitialAmount=6
	IconFlashMaterial=Shader'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGPFlash'
	PickupClass=Class'BallisticProV55.AP_BOGPGrenades'
	IconMaterial=Texture'BW_Core_WeaponTex.BOGP.AmmoIcon_BOGP'
	IconCoords=(X2=64,Y2=64)
	ItemName="Conqueror Grenades"

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
