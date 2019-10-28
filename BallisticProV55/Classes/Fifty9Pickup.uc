//=============================================================================
// Fifty9Pickup.
//=============================================================================
class Fifty9Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.Fifty9.Fifty9Skin');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.Fifty9.Fifty9Skin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.XK2Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Fifty9.Fifty9PickupLD');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Fifty9.Fifty9PickupHD');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.Fifty9.Fifty9PickupLD'
     PickupDrawScale=0.350000
     InventoryType=Class'BallisticProV55.Fifty9MachinePistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the Fifty-9 machine pistol."
     PickupSound=Sound'BallisticSounds2.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.Fifty9.Fifty9PickupHD'
     Physics=PHYS_None
     DrawScale=0.600000
     PrePivot=(Y=-16.000000)
     CollisionHeight=4.000000
}
