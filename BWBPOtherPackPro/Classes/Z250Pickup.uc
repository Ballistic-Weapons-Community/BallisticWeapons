//=============================================================================
// XMV850Pickup.
//=============================================================================
class Z250Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

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
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.Z250.Z250_static_test_01'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBPOtherPackPro.Z250Minigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the Z250 minigun."
     PickupSound=Sound'BallisticSounds2.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.Z250.Z250_static_test_01'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.600000
     PrePivot=(Z=15.000000)
     CollisionHeight=8.000000
}
