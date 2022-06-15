//=============================================================================
// AP_600HEAP.
//
// 14 massive .600 HEAP rounds.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_600HEAP extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=14
     InventoryType=Class'BWBP_SKC_Pro.Ammo_600HEAP'
     PickupMessage="You got 14 .600 HEAP rounds"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.AH104.AH104_SM_Ammo'
     DrawScale=0.100000
     PrePivot=(Z=75.000000)
     CollisionRadius=8.000000
     CollisionHeight=18.000000
}
