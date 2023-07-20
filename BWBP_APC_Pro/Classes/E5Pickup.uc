//=============================================================================
// E5Pickup.
//=============================================================================
class E5Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.MVPR.MVPR_Weapon'
     PickupDrawScale=0.080000
     InventoryType=Class'BWBP_APC_Pro.E5PlasmaRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the E-5 'ViPeR'."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.MVPR.MVPR_Weapon'
     Physics=PHYS_None
     DrawScale=0.080000
     CollisionHeight=4.500000
}
