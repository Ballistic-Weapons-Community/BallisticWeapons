//=============================================================================
// AP_MACShells.
//
// Ammo pickup for HAMR
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MACShells extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=5
     InventoryType=Class'BallisticProV55.Ammo_MAC'
     PickupMessage="You picked up 5 HAMR shells."
     PickupSound=Sound'BallisticSounds2.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWBP4-Hardware.Artillery.Artillery-Ammo'
     DrawScale=0.350000
     PrePivot=(Z=-13.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
