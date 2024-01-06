//=============================================================================
// AP_12GaugeBox.
//
// A box of 20 12 gauge shotgun shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_FM13GasBox extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=1
     InventoryType=Class'BWBP_APC_Pro.Ammo_FM13Gas'
     PickupMessage="You picked up a box of 1 Oil Slick."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.Dragon.Pitbull_Object_Ammo'
     DrawScale=0.050000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
