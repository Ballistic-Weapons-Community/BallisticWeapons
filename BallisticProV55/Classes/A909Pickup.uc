//=============================================================================
// A909Pickup.
//=============================================================================
class A909Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.A909.WristBladeSkin');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A73BladeCut');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A73BladeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A909.WristBladeSkin');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A73BladeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A73BladeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A909.A909Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A909.A909Lo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.A909.A909Lo'
     PickupDrawScale=0.300000
     InventoryType=Class'BallisticProV55.A909SkrithBlades'
     RespawnTime=10.000000
     PickupMessage="You picked up the A909 Skrith wrist blades."
     PickupSound=Sound'BallisticSounds2.A909.A909Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.A909.A909Hi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.350000
     CollisionHeight=4.000000
}
