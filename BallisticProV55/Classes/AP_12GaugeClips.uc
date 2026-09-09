//=============================================================================
// AP_12GaugeClips.
//
// Two clips for MRT6 with six 12 gauge shells in each
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_12GaugeClips extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=12
     InventoryType=Class'BallisticProV55.Ammo_12Gauge'
     PickupMessage="You picked up two MRT-6 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ShotBoxPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.MRT6Clip'
     DrawScale=0.500000
     PrePivot=(Z=-13.000000)
     CollisionRadius=13.000000
     CollisionHeight=6.000000
}
