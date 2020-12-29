//=============================================================================
// AP_leMat.
//
// Ammo pickup includeing 18 .41 bullets and 5 16 gauge shells for the Wilson DB.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_leMat extends BallisticAmmoPickup;

function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_16GaugeleMat';
	AmmoAmount = 5;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_leMat(Copy2).Shells = Ammo_16GaugeleMat(Copy);
	Ammo_16GaugeleMat(Copy).Bullets = Ammo_leMat(Copy2);
	return Copy2;
}

defaultproperties
{
     AmmoAmount=18
     InventoryType=Class'BallisticProV55.Ammo_leMat'
     PickupMessage="You picked up assorted Wilson 41 ammunition."
     PickupSound=Sound'BallisticSounds2.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP4-Hardware.leMat.leMatAmmo'
     DrawScale=0.250000
     PrePivot=(Z=-30.000000)
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
