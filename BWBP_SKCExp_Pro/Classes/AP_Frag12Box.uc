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
     AmmoAmount=2
     InventoryType=Class'BWBP_SKCExp_Pro.Ammo_20mmGrenade'
     PickupMessage="You picked up 3 Toxic Explosives"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Ammo'
     DrawScale=0.300000
     PrePivot=(Z=-2.000000)
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
