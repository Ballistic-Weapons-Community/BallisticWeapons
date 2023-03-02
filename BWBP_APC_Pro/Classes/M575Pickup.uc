//=============================================================================
// M575Pickup.
//=============================================================================
class M575Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.M575.Pickup_M575'
     PickupDrawScale=0.10000
     StandUp=(Y=0.800000)
     InventoryType=Class'BWBP_APC_Pro.M575Machinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M575 machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M353.M353-Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.M575.Pickup_M575'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=12.000000
	 CollisionRadius=52.000000
}
