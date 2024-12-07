//=============================================================================
// MJ51Pickup.
//=============================================================================
class SRKSmgPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupLo'
     InventoryType=Class'BWBP_APC_Pro.SRKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SRK-205 Sub-Machine Gun"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
