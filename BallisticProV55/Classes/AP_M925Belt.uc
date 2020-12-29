//=============================================================================
// AP_M925Belt.
//
// 50 Rounds of .50 Calibre ammo on an M925 belt enclosed in a box.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M925Belt extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=50
     InventoryType=Class'BallisticProV55.Ammo_50CalBelt'
     PickupMessage="You picked up a belt of .50 cal rounds."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.MGBoxPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M925AmmoBox'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=7.500000
}
