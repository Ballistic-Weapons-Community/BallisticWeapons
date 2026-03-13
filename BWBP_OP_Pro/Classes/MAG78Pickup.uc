//=============================================================================
// MAG78Pickup
//=============================================================================
class MAG78Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

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
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.MAGSaw.MAGsawPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.MAGSaw.MAGsawPickupLo');
}

defaultproperties
{
     bOnSide=True
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.MAGSaw.MAGsawPickupLo'
     InventoryType=Class'BWBP_OP_Pro.MAG78Longsword'
     RespawnTime=10.000000
	 PickupDrawScale=0.225000
     PickupMessage="You picked up the MAG-SAW longsword."
     PickupSound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.MAGSaw.MAGsawPickupHi'
     Physics=PHYS_None
     DrawScale=0.120000
     CollisionHeight=3.500000
}
