//=============================================================================
// FP7Pickup.
//=============================================================================
class NTOVPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.NTOV.NTovPickup'
     PickupDrawScale=0.500000
     bWeaponStay=False
     InventoryType=Class'BWBP_SWC_Pro.NTOVBandage'
     RespawnTime=20.000000
     PickupMessage="You picked up the N-TOV Emergency Bandage"
     PickupSound=Sound'BW_Core_WeaponSound.Health.NTovPickup'
     StaticMesh=StaticMesh'BWBP_SWC_Static.NTOV.NTovPickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     CollisionRadius=8.000000
     CollisionHeight=3.500000
}
