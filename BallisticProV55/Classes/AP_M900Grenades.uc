//=============================================================================
// AP_M900Grenades.
//
// 3 grenades for the M900.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_M900Grenades extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BallisticProV55.Ammo_M900Grenades'
     PickupMessage="You picked up 3 grenades for the M900."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M900Grenades'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
