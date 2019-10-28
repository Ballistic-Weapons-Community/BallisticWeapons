//=============================================================================
// RS8Pickup.
//=============================================================================
class RS8Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BWAddPack-RS-Skins.utx
#exec OBJ LOAD FILE=BWAddPack-RS-Effects.utx
#exec OBJ LOAD FILE=BWAddPack-RS-Hardware.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.RS8.RS8-Shiney');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.RS8.RS8-Shiney');
}
simulated function UpdatePrecacheStaticMeshes()
{
//	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-Hardware.RS8.RS8Clips');
	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-Hardware.RS8.RS8PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-Hardware.RS8.RS8PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWAddPack-RS-Hardware.RS8.RS8PickupLo'
     PickupDrawScale=0.210000
     InventoryType=Class'BallisticProV55.RS8Pistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the RS8 pistol."
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWAddPack-RS-Hardware.RS8.RS8PickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     PrePivot=(Y=-18.000000)
     CollisionHeight=4.000000
}
