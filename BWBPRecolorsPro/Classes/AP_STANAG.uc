//=============================================================================
// AP_STANAG.
//
// Two 30 round 5.56mm magazines for the MODERN MILITARY RIFLES.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_STANAG extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=60
     InventoryType=Class'BWBPRecolorsPro.Ammo_556mmSTANAG'
     PickupMessage="You picked up two STANAG magazines."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.ClipPickup'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.M4MagazinePickup'
     DrawScale=0.550000
     PrePivot=(Z=5.000000)
     CollisionRadius=8.000000
     CollisionHeight=5.200000
}
