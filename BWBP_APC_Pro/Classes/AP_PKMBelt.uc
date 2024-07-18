//=============================================================================
// AP_M353Belt.
//
// 150 Rounds of 5.56mm ammo on an M353 belt enclosed in a box.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_PKMBelt extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=75
     InventoryType=Class'BWBP_APC_Pro.Ammo_PKMBelt'
     PickupMessage="You picked up a belt of PKM bullets."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.MGBoxPickup'
     StaticMesh=StaticMesh'BWBP_CC_Static.PKMA.PKMAAmmoBox'
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
