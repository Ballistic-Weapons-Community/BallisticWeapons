//=============================================================================
// AP_STANAGShockwave.
//
// Two 30 round 5.45mm magazines for the MODERN MILITARY RIFLES.
// Comes with BRINK shockwave grenades!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_STANAGShockwave extends BallisticAmmoPickup;

function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_BRINKGrenades';
	AmmoAmount = 2;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_545mmSTANAG(Copy2).Grenades = Ammo_BRINKGrenades(Copy);
	Ammo_BRINKGrenades(Copy).Bullets = Ammo_545mmSTANAG(Copy2);
	return Copy2;
}

defaultproperties
{
     AmmoAmount=120
     InventoryType=Class'BWBP_SWC_Pro.Ammo_545mmSTANAG'
     PickupMessage="You picked up two BR1-NK magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SWC_Static.BRINK.BRINKClip'
     DrawScale=0.100000
     PrePivot=(Z=5.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
