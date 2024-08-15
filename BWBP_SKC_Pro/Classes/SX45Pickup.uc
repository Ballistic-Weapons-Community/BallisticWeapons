//=============================================================================
// RS8Pickup.
//=============================================================================
class SX45Pickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.SX45.SX45PickupLo'
     PickupDrawScale=0.10000
     InventoryType=Class'BWBP_SKC_Pro.SX45Pistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the SX45 pistol."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.SX45.SX45PickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     PrePivot=(Y=-18.000000)
     CollisionHeight=4.000000
}
