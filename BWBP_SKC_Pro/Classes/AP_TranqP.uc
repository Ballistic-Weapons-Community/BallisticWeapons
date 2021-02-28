//=============================================================================
// AP_TranqP
//
// A box of 20 toxin darts + 1 med dart.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_TranqP extends BallisticAmmoPickup;

function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_MedDarts';
	AmmoAmount = 1;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_TranqP(Copy2).MedDarts = Ammo_MedDarts(Copy);
	Ammo_MedDarts(Copy).Darts = Ammo_TranqP(Copy2);
	return Copy2;
}

defaultproperties
{
     AmmoAmount=20
     InventoryType=Class'BWBP_SKC_Pro.Ammo_TranqP'
     PickupMessage="You picked up 2 PS-9m magazines."
     PickupSound=Sound'BWBP_SKC_Sounds.VSK.VSK-Holster'
     StaticMesh=StaticMesh'BWBP_SKC_Static.PS9M.PS9MAmmo'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
