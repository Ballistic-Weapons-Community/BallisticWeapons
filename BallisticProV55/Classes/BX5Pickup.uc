//=============================================================================
// BX5Pickup.
//=============================================================================
class BX5Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.BX5.BX5Skin');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Effects.VBlast');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Effects.HBlast');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MineSBase2');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MineSProj2');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MineV2');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.BX5.BX5Skin');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Effects.VBlast');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Effects.HBlast');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MineSBase2');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MineSProj2');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MineV2');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MinePickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.BX5.MinePickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.BX5.MinePickupLo'
     PickupDrawScale=0.300000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.BX5Mine'
     RespawnTime=20.000000
     PickupMessage="You picked up the BX5-SM land mine."
     PickupSound=Sound'BallisticSounds2.BX5.BX5-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.BX5.MinePickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.650000
     CollisionHeight=5.600000
}
