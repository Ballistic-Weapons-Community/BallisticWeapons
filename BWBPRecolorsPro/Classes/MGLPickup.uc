//=============================================================================
// MGLPickup.
//=============================================================================
class MGLPickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-Holosight');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-Screen');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-Holosight');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-Screen');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.MGL.MGL-ScreenBase');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.MGL.MGLPickupHigh');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.MGL.MGLPickupLow');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.MGL.MGLPickupLow'
     InventoryType=Class'BWBPRecolorsPro.MGLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the Conqueror multiple grenade launcher."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.MGL.MGLPickupHigh'
     Physics=PHYS_None
     DrawScale=0.900000
     CollisionHeight=3.000000
}
