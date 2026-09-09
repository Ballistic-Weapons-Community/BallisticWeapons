//=============================================================================
// AP_Frag12Box
//
// some boom booms for the boom boom gun
//
// by George W. Bush
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_Frag12Box extends BallisticAmmoPickup;

simulated event PreBeginplay()
{
}

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BWBP_SKC_Pro.Ammo_20mmGrenade'
     PickupMessage="You picked up 3 FRAG-12 explosives."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Ammo'
     DrawScale=0.350000
     PrePivot=(Z=72.000000)
     CollisionRadius=19.000000
     CollisionHeight=39.000000
}
