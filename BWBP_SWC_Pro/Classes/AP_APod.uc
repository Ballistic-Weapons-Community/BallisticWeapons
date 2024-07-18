//=============================================================================
// AP_M75Clip.
//
// 2 x 7 round clip for the M75.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_APod extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=2
     InventoryType=Class'BWBP_SWC_Pro.Ammo_APod'
     PickupMessage="You picked up 2 A-Pod Capsules"
     PickupSound=Sound'BW_Core_WeaponSound.Health.AdrenalinPickup'
     //StaticMesh=StaticMesh'BWBP_SWC_Static.APod.APodPickup'
     DrawScale=0.150000
     CollisionRadius=12.000000
     CollisionHeight=5.000000
}
