//=============================================================================
// AP_RS8Clip.
//
// 2 clips for th RS8.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SX45Clip extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=36
     InventoryType=Class'BWBP_SKC_Pro.Ammo_SX45Bullets'
     PickupMessage="You picked up four SX45 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.RS8.RS8Clips'
     DrawScale=0.300000
     PrePivot=(Z=-12.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
