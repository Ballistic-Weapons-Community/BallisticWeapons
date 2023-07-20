//=============================================================================
// AP_M353Belt.
//
// 150 Rounds of 5.56mm ammo on an M353 belt enclosed in a box.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_ThorLC extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=100
     InventoryType=Class'BWBP_APC_Pro.Ammo_ThorLC'
     PickupMessage="You picked up a Thorb."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.A73CellPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.A73Clip'
	 DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
