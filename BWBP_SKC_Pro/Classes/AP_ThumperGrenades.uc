//=============================================================================
// AP_Laser.
//
// 2 20 round chargers for the LS-14
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_ThumperGrenades extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=10
     InventoryType=Class'BWBP_SKC_Pro.Ammo_ThumperGrenades'
     PickupMessage="You got ten 35mm caseless grenades"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.LS14AmmoPickup'
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
