//=============================================================================
// red bullets.
//=============================================================================
class MG36Pickup extends BallisticWeaponPickup
	placeable;

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.MG36.MG36_Weapon'
     InventoryType=Class'BWBP_SKC_Pro.MG36Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the MK.88 Light Support Weapon"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MG36.MG36_Weapon'
     Physics=PHYS_None
     CollisionHeight=4.000000
	 DrawScale=0.100000
}
