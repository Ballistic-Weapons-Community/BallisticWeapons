//=============================================================================
// FP9Pickup.
//=============================================================================
class FP9Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.FP9A5.FP9Bomb');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.FP9A5.FP9Detonator');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP9.FP9Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.FP9A5.FP9Bomb');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.FP9A5.FP9Detonator');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP9.FP9Proj');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP9.FP9PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP9.FP9PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.FP9.FP9PickupLo'
     PickupDrawScale=0.370000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.FP9Explosive'
     RespawnTime=20.000000
     PickupMessage="You picked up the FP9A5 explosive device."
     PickupSound=Sound'BallisticSounds2.FP9A5.FP9-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.FP9.FP9PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=5.600000
}
