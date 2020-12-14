//=============================================================================
// AP_XRS10Clip.
//
// 2 24 round 10mm clips for the XRS10.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_XRS10Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=48
     InventoryType=Class'BallisticProV55.Ammo_XRS10Bullets'
     PickupMessage="You picked up XRS-10 machine pistol ammo."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.XRS10.XRS10Clips'
     DrawScale=0.300000
     PrePivot=(Z=-16.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
