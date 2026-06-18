//=============================================================================
// AP_FLASHAmmo.
//
// 4 rockets for the STREAAAAAK
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_FLASHAmmo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=4
     InventoryType=Class'BWBP_SKC_Pro.Ammo_FLASH'
     PickupMessage="You picked up 4 Incinerator Rockets"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Flash.FLASHAmmo'
     DrawScale=0.750000
     PrePivot=(Z=6.500000)
     CollisionRadius=13.500000
     CollisionHeight=5.000000
}
