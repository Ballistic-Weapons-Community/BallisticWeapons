//=============================================================================
// MDKPickup.
//=============================================================================
class MDKPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.MDK.MDKPickupLo'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SWC_Pro.MDKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MDK Modular SubMachine Gun."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.MDK.MDKPickupHi''
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
