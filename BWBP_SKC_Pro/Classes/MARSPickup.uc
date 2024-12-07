//=============================================================================
// MRASPickup. Jason MRAS.
//=============================================================================
class MARSPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Scope');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-ScopeLensAlt');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.MARS-SpecScope');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-Scope');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.F2000-ScopeLensAlt');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MARS.MARS-SpecScope');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MARS.MARS2PickupHi');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS2PickupLo'
     InventoryType=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the MARS-2 assault rifle."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MARS.MARS2PickupHi'
     Physics=PHYS_None
	 Drawscale=0.15
     CollisionHeight=4.000000
}
