//=============================================================================
// M30Pickup.
//=============================================================================
class FMPPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MP40.MP40PickupLo'
     InventoryType=Class'BWBP_SKC_Pro.FMPMachinePistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the FMP-2012 Machine Pistol"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MP40.MP40PickupHi'
     Physics=PHYS_None
     DrawScale=0.120000
     CollisionHeight=4.000000
}
