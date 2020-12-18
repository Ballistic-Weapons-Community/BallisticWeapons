//=============================================================================
// EKS43Pickup.
//=============================================================================
class MAG78Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.Longsword.ChainsawLongswordShiny');
	L.AddPrecacheMaterial(TexScaler'BWBPSomeOtherPackTex.Longsword.LongswordChainScaler');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.Longsword.ChainsawLongswordShiny');
	Level.AddPrecacheMaterial(TexScaler'BWBPSomeOtherPackTex.Longsword.LongswordChainScaler');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.MAGSaw.ChainsawSwordPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.MAGSaw.ChainsawSwordPickup'
     InventoryType=Class'BWBPOtherPackPro.MAG78Longsword'
     RespawnTime=10.000000
     PickupMessage="You picked up the MAG-SAW longsword."
     PickupSound=Sound'BallisticSounds2.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.MAGSaw.ChainsawSwordPickup'
     Physics=PHYS_None
     DrawScale=1.60000
     CollisionHeight=3.500000
}
