//=============================================================================
// M763Pickup.
//=============================================================================
class FM13Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Dragon.Pitbull_Object'
     InventoryType=Class'BWBP_APC_Pro.FM13Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the FM13 Dragon shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Dragon.Pitbull_Object'
     Physics=PHYS_None
     DrawScale=0.15000
     CollisionHeight=3.000000
}
