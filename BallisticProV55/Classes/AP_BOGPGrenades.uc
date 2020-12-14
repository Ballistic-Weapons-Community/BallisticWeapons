//=============================================================================
// AP_BOGPGrenades.
//
// A 5 grenade BOGP pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_BOGPGrenades extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BallisticProV55.Ammo_BOGPGrenades'
     PickupMessage="You got three BORT-85 grenades."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.BOGP.BOGP_AmmoPickup'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
