//=============================================================================
// NRP57Pickup.
//=============================================================================
class NRP57Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.NRP57.Grenade');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.GrenadeClip');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.NRP57.Pineapple');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.NRP57.Grenade');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.GrenadeClip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.NRP57.Pineapple');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.NRP57.NRP57PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.NRP57.NRP57PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.NRP57.NRP57PickupLo'
     PickupDrawScale=0.200000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.NRP57Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the NRP-57 grenade."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticHardware2.NRP57.NRP57PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=5.600000
}
