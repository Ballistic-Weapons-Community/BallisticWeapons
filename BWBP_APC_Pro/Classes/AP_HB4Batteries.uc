//=============================================================================
// AP_BOGPGrenades.
//
// A 5 grenade BOGP pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_HB4Batteries extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=6
     InventoryType=Class'BWBP_APC_Pro.Ammo_HB4'
     PickupMessage="You got 2 Grenade Batteries."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_CC_Static.HoloBlaster.HoloBlaster_SM_Ammo'
     DrawScale=0.120000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
