//=============================================================================
// AP_SRS900Clip.
//
// Two 20 round 7.62mm magazines for the SRS900.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SRS900Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=40
     InventoryType=Class'BallisticProV55.Ammo_RS762mm'
     PickupMessage="You picked up two SRS-900 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.SRS900.SRS900Clip'
     DrawScale=0.650000
     PrePivot=(Z=-9.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
