//=============================================================================
// Akeron Launcher pickup.
//=============================================================================
class AkeronPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronFront');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronBack');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronGrip');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronMag');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.G5Rocket');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaBackFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronFront');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronBack');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronGrip');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.Akeron.AkeronMag');
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
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic3.Akeron.AkeronAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic3.Akeron.AkeronHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic3.Akeron.AkeronLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic3.Akeron.AkeronLo'
     PickupDrawScale=1.450000
     InventoryType=Class'BWBPOtherPackPro.AkeronLauncher'
     RespawnTime=20.000000
     PickupMessage="You picked up the AN-56 Akeron launcher."
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic3.Akeron.AkeronHi'
     Physics=PHYS_None
     DrawScale=1.450000
     CollisionHeight=6.000000
}
