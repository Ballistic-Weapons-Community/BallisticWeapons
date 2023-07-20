//=============================================================================
// TridentPickup
//=============================================================================
class TridentPickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     bOnSide=False
	 LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.CruMG.CruMG_SM_Pickup'
     InventoryType=Class'BWBP_APC_Pro.TridentMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the Trident Splitter Machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.CruMG.CruMG_SM_Pickup'
     Physics=PHYS_None
	 DrawScale=0.025
     CollisionHeight=4.000000
}
