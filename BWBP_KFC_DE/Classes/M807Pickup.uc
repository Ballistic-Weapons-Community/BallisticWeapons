//=============================================================================
// M806Pickup.
//=============================================================================
class M807Pickup extends BallisticHandgunPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.M806.M806PickupLo'
     PickupDrawScale=0.070000
     InventoryType=Class'BWBP_KFC_DE.M807Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the M807 pistol."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M806.M806PickupHi'
     Physics=PHYS_None
     DrawScale=0.120000
     CollisionHeight=4.000000
}
