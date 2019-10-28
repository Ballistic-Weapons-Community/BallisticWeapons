//=============================================================================
// AP_XMK5Clip.
//
// A 30 round XMK5 magazine, with 3 Darts.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_XMK5Clip extends BallisticAmmoPickup;

function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_XMK5Darts';
	AmmoAmount = 3;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_XMK5Clip(Copy2).Darts = Ammo_XMK5Darts(Copy);
	Ammo_XMK5Darts(Copy).Bullets = Ammo_XMK5Clip(Copy2);
	return Copy2;
}

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BallisticProV55.Ammo_XMK5Clip'
     PickupMessage="You picked up XMk5 SMG rounds and darts."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Ammo'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
