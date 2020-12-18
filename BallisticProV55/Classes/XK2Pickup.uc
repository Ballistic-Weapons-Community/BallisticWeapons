//=============================================================================
// XK2Pickup.
//=============================================================================
class XK2Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.XK2.XK2Skin');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.XK2.XK2Skin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.XK2Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.XK2.XK2PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.XK2.XK2PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.XK2.XK2PickupLo'
     PickupDrawScale=0.250000
     InventoryType=Class'BallisticProV55.XK2SubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the XK2 submachine gun."
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.XK2.XK2PickupHi'
     Physics=PHYS_None
     DrawScale=0.190000
     CollisionHeight=4.000000
}
