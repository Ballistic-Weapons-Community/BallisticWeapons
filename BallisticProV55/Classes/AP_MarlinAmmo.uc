//=============================================================================
// AP_MarlinAmmo.
//
// 16 rounds for the Redwood 6000 DeerMaster rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_MarlinAmmo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=16
     InventoryType=Class'BallisticProV55.Ammo_Marlin'
     PickupMessage="You picked up DeerMaster rounds."
     PickupSound=Sound'BallisticSounds2.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP4-Hardware.Marlin.Marlin-AmmoBox'
     PrePivot=(Z=9.000000)
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
