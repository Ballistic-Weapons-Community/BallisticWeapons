//=============================================================================
// AP_PumaCells
//
// Two PUMA mags
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_PumaCells extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=16
     InventoryType=Class'BWBP_SKC_Pro.Ammo_20mmPuma'
     PickupMessage="You picked up 16 PUMA power cells"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.PUMA.PUMA_SM_Ammo'
     DrawScale=0.300000
     CollisionRadius=8.000000
     CollisionHeight=4.500000
}
