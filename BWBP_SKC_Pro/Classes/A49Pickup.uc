//=============================================================================
// A49Pickup.
//=============================================================================
class A49Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6PlasmaMask');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6Skin');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6PlasmaMask');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6SpecMask');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.Ripple-A49');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A42.A42_Exp');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A42Scorch');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.A49.A49PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.A49.A49PickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6PlasmaMask');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6Skin');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6PlasmaMask');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.A6SpecMask');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.A6.Ripple-A49');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A42.A42_Exp');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A42Scorch');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.A49.A49PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.A49.A49PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.A49.A49PickupLo'
     PickupDrawScale=0.187000
     InventoryType=Class'BWBP_SKC_Pro.A49SkrithBlaster'
     RespawnTime=20.000000
     PickupMessage="You picked up the A49 Skrith blaster."
     PickupSound=Sound'BW_Core_WeaponSound.A42.A42-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.A49.A49PickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.500000
}
