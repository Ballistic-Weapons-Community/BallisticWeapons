//=============================================================================
// D49Pickup.
//=============================================================================
class D49Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.D49.D49RevolverSkin');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.D49.D49ShellsSkin');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.D49.D49RevolverSkin');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.D49.D49ShellsSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.D49.D49AmmoBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.D49.D49PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.D49.D49PickupHi');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.D49.D49PickupLo'
     PickupDrawScale=0.300000
     InventoryType=Class'BallisticProV55.D49Revolver'
     RespawnTime=10.000000
     PickupMessage="You picked up the D49 revolver."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.D49.D49PickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}
