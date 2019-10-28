//=============================================================================
// MRT6Pickup.
//=============================================================================
class MRT6Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.MRT6.MRT6Skin');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Brass.Cart_Shotgun2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.MRT6.MRT6MuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.MRT6.MRT6Skin');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Brass.Cart_Shotgun2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.MRT6.MRT6MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.MRT6Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.MRT6.MRT6PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.MRT6.MRT6PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.MRT6.MRT6PickupLo'
     PickupDrawScale=0.450000
     InventoryType=Class'BallisticProV55.MRT6Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MRT-6 shotgun."
     PickupSound=Sound'BallisticSounds2.MRT6.MRT6Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.MRT6.MRT6PickupHi'
     Physics=PHYS_None
     DrawScale=0.800000
     CollisionHeight=3.500000
}
