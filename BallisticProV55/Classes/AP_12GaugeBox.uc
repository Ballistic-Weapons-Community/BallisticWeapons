//=============================================================================
// AP_12GaugeBox.
//
// A box of 20 12 gauge shotgun shells.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_12GaugeBox extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=10
     InventoryType=Class'BallisticProV55.Ammo_12Gauge'
     PickupMessage="You picked up a box of 12 gauge shells."
     PickupSound=Sound'BallisticSounds2.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BallisticHardware2.Ammo.M763ShellBox'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
