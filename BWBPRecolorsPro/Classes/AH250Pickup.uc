//=============================================================================
// AH250Pickup. DE pickup.
//=============================================================================
class AH250Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx
#exec OBJ LOAD FILE=BWBP_SKC_StaticExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-MainSilverEngraved');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontSilver');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeRed');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-SightReticleGreen');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-MainSilverEngraved');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontSilver');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeRed');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Eagle.Eagle-SightReticleGreen');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.DesertEagle.DeaglePickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.DesertEagle.DeaglePickup'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBPRecolorsPro.AH250Pistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the AH250 'Hawk' scoped pistol."
     PickupSound=Sound'BW_Core_WeaponSound.MRT6.MRT6Pullout'
     StaticMesh=StaticMesh'BWBP_SKC_Static.DesertEagle.DeaglePickup'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
