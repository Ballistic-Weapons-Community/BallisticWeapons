//=============================================================================
// AP_CX61Mag.
//
// 2 x 40 round clips for the SAR 12.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_CX61Mag extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=64
     //InventoryType=Class'BWBP_OP_Pro.Ammo_CX61Rounds'
     InventoryType=Class'BallisticProV55.Ammo_556mm'
     PickupMessage="You picked up two CX61 magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.CX61.CX61AmmoPickup'
     DrawScale=0.550000
     PrePivot=(Z=34.000000)
     CollisionRadius=8.000000
     CollisionHeight=14.000000
}
