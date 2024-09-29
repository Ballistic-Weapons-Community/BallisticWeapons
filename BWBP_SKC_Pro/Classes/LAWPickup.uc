//=============================================================================
// LAWPickup.
//=============================================================================
class LAWPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LAW.LAW-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LAW.LAW-Rocket');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LAW.LAW-ScopeView');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LAW.LAWRocket');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaBackFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LAW.LAW-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LAW.LAW-Rocket');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LAW.LAW-ScopeView');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LAW.LAWRocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaBackFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LAW.LAWAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LAW.LAWPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LAW.LAWPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.LAW.LAWPickupLo'
     PickupDrawScale=0.700000
     InventoryType=Class'BWBP_SKC_Pro.LAWLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the FGM-70 'Shockwave' LAW."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LAW.LAWPickupHi'
     Physics=PHYS_None
     DrawScale=0.450000
     CollisionHeight=6.000000
}
