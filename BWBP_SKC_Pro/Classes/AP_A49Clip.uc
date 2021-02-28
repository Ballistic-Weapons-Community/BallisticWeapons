//=============================================================================
// AP_A49Clip
//
// The charge module from the A49 Skrith Rifle. Gives ammo between 50 amd 80.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_A49Clip extends BallisticAmmoPickup;

// Some of these are good, some not so good
auto state Pickup
{
	function BeginState()
	{
		AmmoAmount = default.AmmoAmount + (-10 + Rand(25));
		Super.BeginState();
	}
}

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BallisticProV55.Ammo_Cells'
     PickupMessage="You picked up an energy cell"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.A73CellPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.A49.A49Ammo'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
