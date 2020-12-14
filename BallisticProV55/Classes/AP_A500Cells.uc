//=============================================================================
// AP_A500Cells
//
// The charge module from the A500 Skrith Acid Gun.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_A500Cells extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=16
     InventoryType=Class'BallisticProV55.Ammo_A500Cells'
     PickupMessage="You picked up some A500 Skrith chemicals."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.A73CellPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Reptile.Reptile_Ammo'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
