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
     MaxAmmo=108
     InitialAmount=54
     IconFlashMaterial=Shader'BW_Core_WeaponTex.Icons.AmmoIconsFlashing'
     PickupClass=Class'BWBPOtherPackPro.AP_MX32Rockets'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.AmmoIconPage'
     IconCoords=(X1=128,X2=191,Y2=63)
     ItemName="MX-32 Rockets"
}
