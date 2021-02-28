//=============================================================================
// AP_CYLOINC.
//
// A 25 round 7.62mm incendiary magazine.
//
// by Casey 'Xavious' Johnson
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_CYLOInc extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=78
     InventoryType=Class'BWBPRecolorsPro.Ammo_CYLOInc'
     PickupMessage="You picked up Firestorm incendiary rounds."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOAmmo'
     DrawScale=2.350000
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
