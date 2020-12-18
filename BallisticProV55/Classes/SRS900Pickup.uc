//=============================================================================
// SRS900Pickup.
//=============================================================================
class SRS900Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP3-Tex.utx
#exec OBJ LOAD FILE=BWBP3Hardware.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP3-Tex.SRS900.SRS900Main');
	L.AddPrecacheMaterial(Texture'BWBP3-Tex.SRS900.SRS900Scope');
	L.AddPrecacheMaterial(Texture'BWBP3-Tex.SRS900.SRS900Ammo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP3-Tex.SRS900.SRS900Main');
	Level.AddPrecacheMaterial(Texture'BWBP3-Tex.SRS900.SRS900Scope');
	Level.AddPrecacheMaterial(Texture'BWBP3-Tex.SRS900.SRS900Ammo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP3Hardware.SRS900.SRS900Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP3Hardware.SRS900.SRS900PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP3Hardware.SRS900.SRS900PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP3Hardware.SRS900.SRS900PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.SRS900Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the SRS-900 battle rifle."
     PickupSound=Sound'BallisticSounds2.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP3Hardware.SRS900.SRS900PickupHi'
     Physics=PHYS_None
     DrawScale=0.500000
     CollisionHeight=3.000000
}
