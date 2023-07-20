//=============================================================================
// AP_CYLOClip.
//
// A 25 round 7.62mm caseless magazine.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_ZX98Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=80
     InventoryType=Class'BWBP_APC_Pro.Ammo_ZX98'
     PickupMessage="You picked up ZX98 rounds."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_CC_Static.AR.AR_Pickup_Mag'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
