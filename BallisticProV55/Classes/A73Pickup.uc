//=============================================================================
// A73Pickup.
//=============================================================================
class A73Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73AmmoSkin');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73BladeSkin');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73SkinA');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73SkinB');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A73Scorch');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73Projectile');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73Projectile2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A73.A73Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A73.A73MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73AmmoSkin');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73BladeSkin');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73SkinA');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A73.A73SkinB');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A73Scorch');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73Projectile');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73Projectile2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A73.A73Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A73.A73MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A73.A73PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A73.A73PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.A73.A73PickupLo'
     InventoryType=Class'BallisticProV55.A73SkrithRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the A73 Skrith rifle."
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.A73.A73PickupHi'
     Physics=PHYS_None
     DrawScale=0.187500
     CollisionHeight=4.500000
}
