//=============================================================================
// G5Pickup.
//=============================================================================
class G5Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Bazooka');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Rocket');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Scope');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Inner');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.G5Rocket');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaBackFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Bazooka');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Rocket');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Scope');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.G5.G5Inner');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.G5Rocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaBackFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.G5Rockets');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.G5PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.G5PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.G5.G5PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.G5Bazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the G5 missile launcher."
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.G5.G5PickupHi'
     Physics=PHYS_None
     DrawScale=0.450000
     CollisionHeight=6.000000
}
