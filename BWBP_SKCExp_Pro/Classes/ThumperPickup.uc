//=============================================================================
// R9Pickup.
//=============================================================================
class ThumperPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.Thumper.ThumperPickup'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SKCExp_Pro.ThumperGrenadeLauncher'
     RespawnTime=20.000000
     PickupMessage="You picked up the LRGh-90 Grenade Launcher."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.Thumper.ThumperPickup'
     Physics=PHYS_None
     DrawScale=0.10000
     CollisionHeight=3.500000
}
