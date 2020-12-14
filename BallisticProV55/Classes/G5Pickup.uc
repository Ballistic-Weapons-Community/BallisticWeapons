//=============================================================================
// G5Pickup.
//=============================================================================
class G5Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Bazooka');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Rocket');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Scope');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Inner');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaBackFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Bazooka');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Rocket');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Scope');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.G5.G5Inner');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaBackFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.G5Rockets');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.G5PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.G5PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.G5Bazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the G5 missile launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5PickupHi'
     Physics=PHYS_None
     DrawScale=0.450000
     CollisionHeight=6.000000
}
