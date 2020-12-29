//=============================================================================
// M75Pickup.
//=============================================================================
class M75Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75Clip');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75Pack');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75PartA');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75PartB');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75Scope');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.M75MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailCoreWave');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailCoreWaveCap');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailShock');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailSmokeCore');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailSpiralSmoke');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.RailImpact');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M75.M75MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75Clip');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75Pack');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75PartA');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75PartB');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M75.M75Scope');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.M75MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailCoreWave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailCoreWaveCap');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailShock');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailSmokeCore');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.RailSpiralSmoke');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.RailImpact');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M75.M75MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M75Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M75.M75Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M75.M75Lo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M75.M75Lo'
     PickupDrawScale=0.300000
     StandUp=(Y=0.800000)
     InventoryType=Class'BallisticProV55.M75Railgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M75 railgun."
     PickupSound=Sound'BallisticSounds2.M75.M75Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.M75.M75Hi'
     Physics=PHYS_None
     DrawScale=0.270000
     CollisionHeight=3.000000
}
