//=============================================================================
// G5Pickup.
//=============================================================================
class RGPXPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350_SM_Main'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_JCF_Pro.RGPXBazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the RGK-350 H-V Flak Bazooka."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350_SM_Main'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=6.000000
}
