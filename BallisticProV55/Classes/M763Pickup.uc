//=============================================================================
// M763Pickup.
//=============================================================================
class M763Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M763.M763Shotgun');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.M763.M763Small');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763Flash1');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M763.M763Shotgun');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.M763.M763Small');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763Bash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763BashWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M763ShellBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.M763.M763PickupLo'
     InventoryType=Class'BallisticProV55.M763Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M763 shotgun."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.M763.M763PickupHi'
     Physics=PHYS_None
     DrawScale=0.190000
     CollisionHeight=3.000000
}
