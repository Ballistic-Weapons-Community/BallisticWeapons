//=============================================================================
// MACPickup.
//=============================================================================
class MACPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Artillery.Artillery_Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Artillery.Artillery_Glass');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');

	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Artillery.Blast-FX');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Artillery.Artillery_Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Artillery.Artillery_Glass');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Artillery.ArtilleryPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Artillery.ArtilleryPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Artillery.Blast-FX');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Artillery.Artillery-Ammo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.Artillery.ArtilleryPickup-LD'
     PickupDrawScale=0.250000
     InventoryType=Class'BallisticProV55.MACWeapon'
     RespawnTime=120.000000
     PickupMessage="You picked up the Heavy Anti-Materiel Rifle."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Artillery.ArtilleryPickup-HD'
     Physics=PHYS_None
     DrawScale=0.325000
     PrePivot=(Z=-14.000000)
     CollisionHeight=6.000000
}
