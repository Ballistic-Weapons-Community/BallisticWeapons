//=============================================================================
// AP_8Gauge.
//
// Two boxes of 6 HE shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_RCS715Shotgun extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=45
     InventoryType=Class'BWBP_OP_Pro.Ammo_RCS715Shotgun'
     PickupMessage="You picked up 3 magazines for the RCS-715 Shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.TacticalBuster.AA12AmmoPickup'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
