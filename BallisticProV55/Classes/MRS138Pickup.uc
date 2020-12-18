//=============================================================================
// MRS138Pickup.
//=============================================================================
class MRS138Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.MRS138.MRS138Shiney');
	L.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.MRS138.MRS138HeatShiney');
	L.AddPrecacheMaterial(Texture'BWAddPack-RS-Skins.MRS138.MRS138Shell');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.MRS138.MRS138Shiney');
	Level.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.MRS138.MRS138HeatShiney');
	Level.AddPrecacheMaterial(Texture'BWAddPack-RS-Skins.MRS138.MRS138Shell');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-Hardware.MRS138.MRS138PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-Hardware.MRS138.MRS138PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWAddPack-RS-Hardware.MRS138.MRS138PickupLo'
     PickupDrawScale=0.190000
     InventoryType=Class'BallisticProV55.MRS138Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MRS-138 tactical shotgun."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BWAddPack-RS-Hardware.MRS138.MRS138PickupHi'
     Physics=PHYS_None
     DrawScale=0.250000
     PrePivot=(Y=-18.000000)
     CollisionHeight=3.000000
}
