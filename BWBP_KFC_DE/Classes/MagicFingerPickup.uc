//=============================================================================
// @%Q%!@
//=============================================================================
class MagicFingerPickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.A42.A42PickupLo'
     PickupDrawScale=0.187000
     InventoryType=Class'BWBP_KFC_DE.MagicFinger'
     RespawnTime=20.000000
     PickupMessage="You picked up the SMARF Launcher"
     PickupSound=Sound'BW_Core_WeaponSound.A42.A42-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.A42.A42PickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.500000
}
