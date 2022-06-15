//=============================================================================
// AP_AR23Clip.
//
// 2 clips for th RS8.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_AR23Clip extends BallisticAmmoPickup;

function inventory SpawnCopy( Pawn Other )
{
	local Inventory Copy, Copy2;

	InventoryType = Class'Ammo_AR23Grenades';
	AmmoAmount = 1;
	Copy = Super.SpawnCopy(Other);
	AmmoAmount = default.AmmoAmount;
	InventoryType = default.InventoryType;

	Copy2 = Super.SpawnCopy(Other);
	Ammo_AR23Bullets(Copy2).Grenades = Ammo_AR23Grenades(Copy);
	Ammo_AR23Grenades(Copy).Bullets = Ammo_AR23Bullets(Copy2);
	return Copy2;
}

defaultproperties
{
     AmmoAmount=54
     InventoryType=Class'BWBP_SKC_Pro.Ammo_AR23Bullets'
     PickupMessage="You picked up three AR23 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.AR23.AR23_SM_Ammo'
     DrawScale=0.130000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
