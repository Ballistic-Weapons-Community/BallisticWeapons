//=============================================================================
// R9Pickup.
//=============================================================================
class R9A1Pickup extends BallisticWeaponPickup
	placeable;

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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R9.USSRSkin');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R9.USSRSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.R9A1.R9A1PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.R9A1.R9A1PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.USSR.USSRClips');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.R9A1.R9A1PickupLo'
     PickupDrawScale=0.240000
     InventoryType=Class'BWBP_OP_Pro.R9A1RangerRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the R9A1 ranger rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.R9A1.R9A1PickupHi'
     Physics=PHYS_None
     DrawScale=0.350000
     CollisionHeight=3.000000
}
