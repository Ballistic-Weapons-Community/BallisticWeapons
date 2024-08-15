//=============================================================================
// R9Pickup.
//=============================================================================
class ThumperPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.Thumper.ThumperPickupLo'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SKC_Pro.ThumperGrenadeLauncher'
     RespawnTime=20.000000
     PickupMessage="You picked up the LRGh-90 Grenade Launcher."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Thumper.ThumperPickupHi'
     Physics=PHYS_None
     DrawScale=0.10000
     CollisionHeight=3.500000
}
