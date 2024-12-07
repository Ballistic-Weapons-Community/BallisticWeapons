//=============================================================================
// AP_12GaugeBox.
//
// A box of 20 12 gauge shotgun shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_FM14Box extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=12
     InventoryType=Class'BWBP_APC_Pro.Ammo_FM14SlugGauge'
     PickupMessage="You picked up a box of 12 Slug Shells."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.Pitbull.Pickup_Pitbull2_Ammo'
     DrawScale=0.050000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
