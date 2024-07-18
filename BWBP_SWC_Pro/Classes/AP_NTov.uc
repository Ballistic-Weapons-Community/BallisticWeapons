//=============================================================================
// AP_M75Clip.
//
// 2 x 7 round clip for the M75.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_NTov extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=3
     InventoryType=Class'BWBP_SWC_Pro.Ammo_NTov'
     PickupMessage="You picked up 3 N-TOV bandages"
     PickupSound=Sound'BW_Core_WeaponSound.Health.NTovPickup'
     //StaticMesh=StaticMesh'BWBP_SWC_Static.NTOV.NTovPickup'
     DrawScale=0.500000
     CollisionRadius=12.000000
     CollisionHeight=5.000000
}
