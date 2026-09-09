//=============================================================================
// AP_SMATAmmo.
//
// 2 loose rockets for the SMAT
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AP_SMATAmmo extends BallisticAmmoPickup;

defaultproperties
{
     AmmoAmount=2
     InventoryType=Class'BWBP_SKC_Pro.Ammo_SMAT'
     PickupMessage="You picked up 2 SMAT artillery shells"
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.RocketPickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.SMAT.SMATAmmo'
     DrawScale=0.600000
     PrePivot=(Z=5.000000)
     CollisionRadius=14.000000
     CollisionHeight=5.000000
}
