//=============================================================================
// AP_AM67Clip.
//
// Clips for the AM67.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_AM67Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=24
     InventoryType=Class'BallisticProV55.Ammo_50HV'
     PickupMessage="You picked up three AM67 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.AM67.AM67Clips'
     DrawScale=0.200000
     PrePivot=(Z=6.000000)
     CollisionRadius=8.000000
     CollisionHeight=7.000000
}
