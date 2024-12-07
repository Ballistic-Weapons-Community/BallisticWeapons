//=============================================================================
// AP_HydraAmmo.
//
// 6 loose rockets for the Hydra
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_HydraAmmo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=6
     InventoryType=Class'BWBP_APC_Pro.Ammo_HRPG'
     PickupMessage="You picked up a box of Hydra rocket propelled grenades."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWBP_APC_Static.RL.CruRLRockets'
     DrawScale=0.100000
     CollisionRadius=8.000000
     CollisionHeight=5.000000
}
