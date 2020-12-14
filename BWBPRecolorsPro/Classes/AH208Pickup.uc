//=============================================================================
// AH208Pickup. DE pickup.
//=============================================================================
class AH208Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-MainGoldEngraved');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeGold');
	L.AddPrecacheMaterial(Shader'BWBP_SKC_Tex.Eagle.Eagle-GoldShine');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925MuzzleFlash');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-MainGoldEngraved');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeGold');
	Level.AddPrecacheMaterial(Shader'BWBP_SKC_Tex.Eagle.Eagle-GoldShine');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.D49.D49AmmoBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.DesertEagle.DEaglePickupAlt');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.DesertEagle.DeaglePickupAlt'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBPRecolorsPro.AH208Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the AH208 golden pistol."
     PickupSound=Sound'BW_Core_WeaponSound.MRT6.MRT6Pullout'
     StaticMesh=StaticMesh'BWBP_SKC_Static.DesertEagle.DeaglePickupAlt'
     Physics=PHYS_None
     DrawScale=1.000000
     CollisionHeight=4.000000
}
