//=============================================================================
// Ammo_16GuageleMat.
//
// 16 Guage shotgun ammo. Used by Wilson DB revolver.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Ammo_ProtoAlt extends BallisticAmmo;

var   ProtoSMG		Gun;

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
     PickupClass=Class'BWBP_APC_Pro.AP_ProtoAlt'
     IconMaterial=Texture'BW_Core_WeaponTex.leMat.AmmoIcon_Wilson41DB'
     IconCoords=(X2=63,Y2=63)
     ItemName="S1W Photon Rounds"
}
