//=============================================================================
// AP_STANAGShockwave.
//
// Two 30 round 5.45mm magazines for the MODERN MILITARY RIFLES.
// Comes with F2000 shockwave grenades!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_STANAGShockwave extends BallisticAmmoPickup;
/*
function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_MARSGrenades';
	AmmoAmount = 2;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_556mm(Copy2).Grenades = Ammo_MARSGrenades(Copy);
	Ammo_MARSGrenades(Copy).Bullets = Ammo_556mm(Copy2);
	return Copy2;
}*/

defaultproperties
{
     AmmoAmount=60
     InventoryType=Class'BallisticProV55.Ammo_556mm'
     PickupMessage="You picked up two MARS magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARSAmmo'
     DrawScale=0.550000
     PrePivot=(Z=5.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
