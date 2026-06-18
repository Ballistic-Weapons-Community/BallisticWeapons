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
     InventoryType=Class'BWBP_APC_Pro.Ammo_ZX98Rifle'
     PickupMessage="You picked up ZX98 rounds."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_APC_Static.AR.ZX98Clip'
     DrawScale=0.250000
     PrePivot=(Z=17.000000)
     CollisionRadius=14.000000
     CollisionHeight=5.200000
}
