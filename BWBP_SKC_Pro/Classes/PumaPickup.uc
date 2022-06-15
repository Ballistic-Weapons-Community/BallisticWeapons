//=============================================================================
// PumaPickup.
//[1:25:41 AM] Marc Moylan: I HATE POSELIB
//[1:25:43 AM] Captain Xavious: lol
//[1:25:44 AM] Marc Moylan: TOO MUCH MOVEMENT
//[1:25:50 AM] Captain Xavious: noooooooo
//=============================================================================
class PumaPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.PUMA.PumaPickup'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBP_SKC_Pro.PumaRepeater'
     RespawnTime=20.000000
     PickupMessage="You picked up the PUMA-77 Repeater"
     PickupSound=Sound'BWBP_SKC_SoundsExp.PUMA.PUMA-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.PUMA.PumaPickup'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
