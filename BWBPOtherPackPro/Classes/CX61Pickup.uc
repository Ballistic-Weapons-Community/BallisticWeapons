//=============================================================================
// CX61 pickup
//=============================================================================
class CX61Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBPOtherPackTex.utx
#exec OBJ LOAD FILE=BWBPOtherPackStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-Light');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-Main');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-RDS');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-Mag');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61Gas');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.G28Cloud');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-Light');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-Main');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-RDS');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61-Mag');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.CX61Gas');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.CX61.G28Cloud');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.CX61.CX61Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.CX61.CX61PickupLow');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.CX61.CX61AmmoPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.CX61.CX61PickupLow'
     PickupDrawScale=0.550000
     InventoryType=Class'BWBPOtherPackPro.CX61AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the CX61 tactical rifle."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.CX61.CX61Pickup'
     Physics=PHYS_None
     DrawScale=0.550000
     CollisionHeight=4.000000
}
