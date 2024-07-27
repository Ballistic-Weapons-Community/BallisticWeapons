//=============================================================================
// M763Pickup.
//=============================================================================
class FM14Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Pitbull.PitbullPickupLo'
     InventoryType=Class'BWBP_APC_Pro.FM14Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the FM14 Pitbull Blunderbuss."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Pitbull.PitbullPickupHi'
     Physics=PHYS_None
     DrawScale=0.15000
     CollisionHeight=3.000000
}
