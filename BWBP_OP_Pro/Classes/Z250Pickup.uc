//=============================================================================
// XMV850Pickup.
//=============================================================================
class Z250Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{

}

simulated function UpdatePrecacheMaterials()
{

}
simulated function UpdatePrecacheStaticMeshes()
{

}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Z250.Z250_static_test_01'
     PickupDrawScale=0.800000
     InventoryType=Class'BWBP_OP_Pro.Z250Minigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the Z250 minigun."
     PickupSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Z250.Z250_static_test_01'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.800000
     PrePivot=(Z=15.000000)
     CollisionHeight=8.000000
}
