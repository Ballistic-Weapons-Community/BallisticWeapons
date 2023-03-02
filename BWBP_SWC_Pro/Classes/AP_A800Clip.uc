//=============================================================================
// AP_A73Clip
//
// The charge module from the A73 Skrith Rifle. Gives ammo between 30 amd 50.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_A800Clip extends BallisticAmmoPickup;

// Some of these are good, some not so good
auto state Pickup
{
	function BeginState()
	{
		AmmoAmount = default.AmmoAmount + (-20 + Rand(40));
		Super.BeginState();
	}
}

defaultproperties
{
     AmmoAmount=200
     InventoryType=Class'BWBP_SWC_Pro.Ammo_A800Cells'
     PickupMessage="You picked up a Skrith energy cell"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.A73CellPickup'
     StaticMesh=StaticMesh'BWBP_SWC_Static.SkrithMinigun.SkrithBigCellPick'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.800000
}
