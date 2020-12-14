//=============================================================================
// M763Pickup.
//=============================================================================
class M763Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M763.M763Shotgun');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M763.M763Small');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763Flash1');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M763.M763Shotgun');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M763.M763Small');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763Bash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763BashWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M763ShellBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.M763.M763PickupLo'
     InventoryType=Class'BallisticProV55.M763Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M763 shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M763.M763PickupHi'
     Physics=PHYS_None
     DrawScale=0.190000
     CollisionHeight=3.000000
}
