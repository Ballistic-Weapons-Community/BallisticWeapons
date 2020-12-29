//=============================================================================
// AP_A73Clip
//
// The charge module from the A73 Skrith Rifle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_A73Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=64
     InventoryType=Class'BallisticProV55.Ammo_Cells'
     PickupMessage="You picked up an A73 energy cell."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.A73CellPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.A73Clip'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
