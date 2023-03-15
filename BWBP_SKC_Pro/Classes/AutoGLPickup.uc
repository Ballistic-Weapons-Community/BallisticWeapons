//=============================================================================
// MGLPickup.
//=============================================================================
class AutoGLPickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-HolosightBasic');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-Screen');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-HolosightBasic');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-Screen');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MGL.MGLPickupHigh');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MGL.MGLPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MGL.MGLPickupLow'
     InventoryType=Class'BWBP_SKC_Pro.AutoGLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the AG-81 auto grenade launcher."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MGL.MGLPickupHigh'
     Physics=PHYS_None
     DrawScale=0.900000
     CollisionHeight=3.000000
}
