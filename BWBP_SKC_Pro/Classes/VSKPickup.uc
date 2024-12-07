//=============================================================================
// VSKPickup.
//=============================================================================
class VSKPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.VSKS.VSKSPickupLo'
     InventoryType=Class'BWBP_SKC_Pro.VSKTranqRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the VSK-42 Tranquilizer"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.VSKS.VSKSPickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
