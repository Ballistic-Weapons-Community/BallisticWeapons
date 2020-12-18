//=============================================================================
// AM67Pickup.
//=============================================================================
class AM67Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.AM67.AM67Main');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M806.PistolMuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.AM67.AM67Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.AM67.AM67Clips');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.AM67.PickupLD'
     PickupDrawScale=0.190000
     InventoryType=Class'BallisticProV55.AM67Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the AM67 assault pistol."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.AM67.PickupLD'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Y=-26.000000)
     CollisionHeight=4.000000
}
