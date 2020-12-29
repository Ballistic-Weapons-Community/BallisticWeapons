//=============================================================================
// M46PickupQS.
//=============================================================================
class M46PickupQS extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-AR.OA-AR_PickupLo'
     PickupDrawScale=0.400000
     InventoryType=Class'BallisticProV55.M46AssaultRifleQS'
     RespawnTime=20.000000
     PickupMessage="You picked up the M46 battle rifle."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-AR.OA-AR_PickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.000000
}
