//=============================================================================
// FP7Pickup.
//=============================================================================
class FP7Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.FP7.FP7Grenade');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.FlameParts');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.BlazingSubdivide');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.FP7Clip');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP7.FP7Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.FP7.FP7Grenade');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.FlameParts');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.BlazingSubdivide');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.FP7Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP7.FP7Proj');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP7.FP7PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.FP7.FP7PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.FP7.FP7PickupLo'
     PickupDrawScale=0.500000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.FP7Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the FP7 grenade."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticHardware2.FP7.FP7PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     CollisionHeight=5.600000
}
