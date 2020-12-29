//=============================================================================
// AP_Laser.
//
// 2 20 round chargers for the LS-14
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_XM20B extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=100
     InventoryType=Class'BWBPOtherPackPro.Ammo_XM20B'
     PickupMessage="You got 100 XM energy cells."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.LS14AmmoPickup'
     DrawScale=1.000000
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
