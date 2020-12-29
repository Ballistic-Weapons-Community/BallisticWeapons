//=============================================================================
// AP_M353Belt.
//
// 150 Rounds of 5.56mm ammo on an M353 belt enclosed in a box.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M353Belt extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=70
     InventoryType=Class'BallisticProV55.Ammo_556mmBelt'
     PickupMessage="You picked up a belt of M353 bullets."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.MGBoxPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.MachinegunBox'
     CollisionRadius=8.000000
     CollisionHeight=5.500000
}
