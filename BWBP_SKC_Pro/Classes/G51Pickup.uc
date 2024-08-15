//=============================================================================
// G51Pickup.
//=============================================================================
class G51Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MJ51.MJ51PickupLo'
     InventoryType=Class'BWBP_SKC_Pro.G51Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the G51 carbine."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MJ51.MJ51PickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
