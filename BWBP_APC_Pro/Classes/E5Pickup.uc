//=============================================================================
// E5Pickup.
//=============================================================================
class E5Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.MVPR.MVPRPickupLo'
     PickupDrawScale=0.080000
     InventoryType=Class'BWBP_APC_Pro.E5PlasmaRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the E-5 'ViPeR'."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.MVPR.MVPRPickupHi'
     Physics=PHYS_None
     DrawScale=0.080000
     CollisionHeight=4.500000
}
