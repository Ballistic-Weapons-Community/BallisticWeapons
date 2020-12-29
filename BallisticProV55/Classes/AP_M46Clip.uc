//=============================================================================
// AP_M46Clip.
//
// Two 25 round M46 magazines, with a grenade.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M46Clip extends BallisticAmmoPickup;

function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_M46Grenades';
	AmmoAmount = 1;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_M46Clip(Copy2).Grenades = Ammo_M46Grenades(Copy);
	Ammo_M46Grenades(Copy).Bullets = Ammo_M46Clip(Copy2);
	return Copy2;
}

defaultproperties
{
     AmmoAmount=50
     InventoryType=Class'BallisticProV55.Ammo_M46Clip'
     PickupMessage="You picked up assorted M46 battle rifle ammunition."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BallisticHardware_25.OA-AR.OA-AR_Ammo'
     DrawScale=0.400000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
