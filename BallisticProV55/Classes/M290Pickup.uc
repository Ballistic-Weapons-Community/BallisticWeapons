//=============================================================================
// M290Pickup.
//=============================================================================
class M290Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M290.M290Shotgun');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M290.M290Shotgun');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M763ShellBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M290.M290PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M290.M290PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M290.M290PickupLo'
     PickupDrawScale=0.200000
     InventoryType=Class'BallisticProV55.M290Shotgun'
     RespawnTime=120.000000
     PickupMessage="You picked up the M290 shotgun."
     PickupSound=Sound'BallisticSounds2.M290.M290Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.M290.M290PickupHi'
     Physics=PHYS_None
     DrawScale=0.200000
     CollisionHeight=3.500000
}
