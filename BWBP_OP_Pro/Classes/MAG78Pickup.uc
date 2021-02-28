//=============================================================================
// EKS43Pickup.
//=============================================================================
class MAG78Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.Longsword.ChainsawLongswordShiny');
	L.AddPrecacheMaterial(TexScaler'BWBP_OP_Tex.Longsword.LongswordChainScaler');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.Longsword.ChainsawLongswordShiny');
	Level.AddPrecacheMaterial(TexScaler'BWBP_OP_Tex.Longsword.LongswordChainScaler');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.MAGSaw.ChainsawSwordPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.MAGSaw.ChainsawSwordPickup'
     InventoryType=Class'BWBP_OP_Pro.MAG78Longsword'
     RespawnTime=10.000000
     PickupMessage="You picked up the MAG-SAW longsword."
     PickupSound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.MAGSaw.ChainsawSwordPickup'
     Physics=PHYS_None
     DrawScale=1.60000
     CollisionHeight=3.500000
}
