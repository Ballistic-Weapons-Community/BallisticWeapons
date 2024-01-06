//=============================================================================
// ProtoPickup.
//=============================================================================
class ProtoPickup extends BallisticWeaponPickup
	placeable;

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.ProtoLMG.ProtoLMG_SM'
     InventoryType=Class'BWBP_APC_Pro.ProtoSMG'
     RespawnTime=20.000000
     PickupMessage="You picked up the FC-01B Prototype Light Machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.ProtoLMG.ProtoLMG_SM'
     Physics=PHYS_None
     CollisionHeight=4.000000
	 Drawscale=0.1
}
