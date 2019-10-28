//=============================================================================
// XRS10Pickup.
//=============================================================================
class XRS10Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.XRS10.XRS10Shiney');
	L.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.XRS10.XRS10LaserShiney');
	L.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.XRS10.XRS10SilencerShiney');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.XRS10.XRS10Shiney');
	Level.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.XRS10.XRS10LaserShiney');
	Level.AddPrecacheMaterial(Shader'BWAddPack-RS-Skins.XRS10.XRS10SilencerShiney');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-hardware.XRS10.XRS10Clips');
	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-Hardware.XRS10.XRS10PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWAddPack-RS-Hardware.XRS10.XRS10PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWAddPack-RS-Hardware.XRS10.XRS10PickupLo'
     PickupDrawScale=0.190000
     InventoryType=Class'BallisticProV55.XRS10SubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the XRS-10 machine pistol."
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWAddPack-RS-Hardware.XRS10.XRS10PickupHi'
     Physics=PHYS_None
     DrawScale=0.350000
     PrePivot=(Y=-20.000000)
     CollisionHeight=4.000000
}
