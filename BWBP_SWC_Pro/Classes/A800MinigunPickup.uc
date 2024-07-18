//=============================================================================
// XMV850Pickup.
//=============================================================================
class A800MinigunPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.SkrithHyperBlasterPickupLo'
     PickupDrawScale=0.070000
     InventoryType=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the A800 Skrith HyperBlaster"
     PickupSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHyperBlasterPickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.07
     PrePivot=(Z=35.000000)
     CollisionHeight=8.000000
}
