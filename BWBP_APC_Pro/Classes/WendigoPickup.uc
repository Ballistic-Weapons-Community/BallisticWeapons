//=============================================================================
// WendigoPickup.
//=============================================================================
class WendigoPickup extends BallisticWeaponPickup
	placeable;

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupLo'
     InventoryType=Class'BWBP_APC_Pro.WendigoSMG'
     RespawnTime=20.000000
     PickupMessage="You picked up the Wendigo SMG."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupHi'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
