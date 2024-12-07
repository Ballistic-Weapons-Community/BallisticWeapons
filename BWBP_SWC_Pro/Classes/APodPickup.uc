//=============================================================================
// FP7Pickup.
//=============================================================================
class APodPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
     //LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.APod.APodPickup'
     PickupDrawScale=0.150000
     bWeaponStay=False
     InventoryType=Class'BWBP_SWC_Pro.APodCapsule'
     RespawnTime=20.000000
     PickupMessage="You picked up the A-Pod Adrenaline Capsule"
     PickupSound=Sound'BW_Core_WeaponSound.Health.AdrenalinPickup'
     //StaticMesh=StaticMesh'BWBP_SWC_Static.APod.APodPickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.150000
     CollisionRadius=8.000000
     CollisionHeight=3.500000
}
