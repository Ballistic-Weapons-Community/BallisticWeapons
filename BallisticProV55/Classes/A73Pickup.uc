//=============================================================================
// A73Pickup.
//=============================================================================
class A73Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73AmmoSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73BladeSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73SkinA');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73SkinB');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A73Scorch');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73Projectile');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73Projectile2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A73.A73Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A73.A73MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73AmmoSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73BladeSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73SkinA');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73SkinB');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A73Scorch');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73Projectile');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73Projectile2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A73.A73Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A73.A73MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A73.A73PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A73.A73PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73PickupLo'
     InventoryType=Class'BallisticProV55.A73SkrithRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the A73 Skrith rifle."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.A73.A73PickupHi'
     Physics=PHYS_None
     DrawScale=0.150000
     CollisionHeight=4.500000
}
