//=============================================================================
// CYLOPickup.
//=============================================================================
class ZX98Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.AR.AR_Pickup_Main'
     InventoryType=Class'BWBP_APC_Pro.ZX98AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the ZX98 Reaper Gauss Minigun."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.AR.AR_Pickup_Main'
     Physics=PHYS_None
	 DrawScale=0.1
     CollisionHeight=4.000000
}
