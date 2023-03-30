//=============================================================================
// AP_M900Grenades.
//
// 3 grenades for the M900.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_RCS715Grenades extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BWBP_OP_Pro.Ammo_RCS715Grenades'
     PickupMessage="You picked up 3 grenades for the RCS."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.TacticalBuster.AA12GrenadePickup'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=10.000000
}
