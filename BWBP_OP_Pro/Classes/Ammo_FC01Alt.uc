//=============================================================================
// Ammo_FC01Alt.
//
// A tracker dart or battery for the FC01
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_FC01Alt extends BallisticAmmo;

var   FC01SmartGun		Gun;

function bool HandlePickupQuery(Pickup Item)
{
	if (Super.HandlePickupQuery(Item))
	{
		if (Gun != None)
			Gun.PhotonPickedUp();
		return true;
	}
	return false;
}

defaultproperties
{
     MaxAmmo=100
     InitialAmount=40
     IconFlashMaterial=Shader'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DBFlash'
     PickupClass=Class'BWBP_OP_Pro.AP_FC01Alt'
     IconMaterial=Texture'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DB'
     IconCoords=(X2=63,Y2=63)
     ItemName="S1W Photon Rounds"
}
