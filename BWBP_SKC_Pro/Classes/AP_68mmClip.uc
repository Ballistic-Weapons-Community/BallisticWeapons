//=============================================================================
// AP_68mmClip.
//
// A 25 round 6.8mm magazine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_68mmClip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=50
     InventoryType=Class'BWBP_SKC_Pro.Ammo_68mm'
     PickupMessage="You got two 6.8mm magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.M50Magazine'
     DrawScale=0.300000
     PrePivot=(Z=-5.500000)
     CollisionRadius=10.000000
     CollisionHeight=5.200000
}
