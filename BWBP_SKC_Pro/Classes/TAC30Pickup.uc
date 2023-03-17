//=============================================================================
// TAC30Pickup.
//=============================================================================
class TAC30Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.SKAS.SKASShotgunPickup'
     InventoryType=Class'BWBP_SKC_Pro.TAC30Cannon'
     RespawnTime=90.000000
     PickupMessage="You picked up the TAC-30 Autocannon"
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.SKAS.SKASShotgunPickup'
     Physics=PHYS_None
     DrawScale=0.800000
     PickupDrawScale=0.800000
     CollisionHeight=3.000000
}
