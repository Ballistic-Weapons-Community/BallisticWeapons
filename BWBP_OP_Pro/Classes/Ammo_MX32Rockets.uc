class Ammo_MX32Rockets extends BallisticAmmo;

var   MX32Weapon		Gun;

function bool HandlePickupQuery(Pickup Item)
{
	if (Super.HandlePickupQuery(Item))
	{
		if (Gun != None)
			Gun.RocketsPickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=32
     InitialAmount=16
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBP_OP_Pro.AP_MX32Rockets'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="MX-32 Rockets"

	Begin Object Class=AmmoParams Name=ArenaParams
		KillInitialAmmoMult=0.34f
	End Object

	Begin Object Class=AmmoParams Name=ClassicParams
		KillInitialAmmoMult=0.34f
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
