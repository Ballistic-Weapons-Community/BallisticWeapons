//=============================================================================
// CYLOPickup.
//=============================================================================
class CYLOPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.UAW');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.CYLOMag');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.UAW');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CYLO.CYLOMag');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.CYLO.CYLOUAWHigh');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.CYLO.CYLOUAWLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOUAWLow'
     InventoryType=Class'BWBP_SKC_Pro.CYLOUAW'
     RespawnTime=20.000000
     PickupMessage="You picked up the CYLO urban assault weapon."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.CYLO.CYLOUAWHigh'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
