//=============================================================================
// MJ51Pickup.
//=============================================================================
class MJ51Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.CarbineSM'
     InventoryType=Class'BWBP_SKC_Pro.MJ51Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the G51 Carbine"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MJ51.CarbineSM'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
