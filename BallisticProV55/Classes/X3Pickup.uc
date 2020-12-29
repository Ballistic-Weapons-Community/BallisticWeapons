//=============================================================================
// X3Pickup.
//=============================================================================
class X3Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.X3.KnifeA1');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.X3.KnifeA1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.X3.X3PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.X3.X3PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.X3.X3PickupLo'
     PickupDrawScale=0.250000
     InventoryType=Class'BallisticProV55.X3Knife'
     RespawnTime=10.000000
     PickupMessage="You picked up the X3 combat knife."
     PickupSound=Sound'BallisticSounds2.Knife.KnifePutaway'
     StaticMesh=StaticMesh'BallisticHardware2.X3.X3PickupHi'
     Physics=PHYS_None
     DrawScale=0.450000
     CollisionHeight=4.000000
}
