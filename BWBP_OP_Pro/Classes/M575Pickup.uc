//=============================================================================
// M575Pickup.
//=============================================================================
class M575Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.M575.M575PickupLo'
     PickupDrawScale=0.10000
     StandUp=(Y=0.800000)
     InventoryType=Class'BWBP_OP_Pro.M575Machinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M575 machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M353.M353-Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.M575.M575PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.062000
     CollisionHeight=12.000000
	CollisionRadius=52.000000
}
