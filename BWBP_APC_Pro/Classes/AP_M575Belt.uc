//=============================================================================
// AP_M575Belt.
//
// 80 Rounds of 5.56mm ammo on an M575 belt enclosed in a box.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M575Belt extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=85
     InventoryType=Class'BWBP_APC_Pro.Ammo_556mmBelt'
     PickupMessage="You picked up a belt of M575 bullets."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.MGBoxPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.M575.Pickup_M575_Magazine'
     CollisionRadius=8.000000
     CollisionHeight=5.500000
	 DrawScale=0.1
}
