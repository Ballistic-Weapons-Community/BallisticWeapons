//=============================================================================
// M290Pickup.
//=============================================================================
class M290Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M290.M290Shotgun');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M290.M290Shotgun');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M763ShellBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M290.M290PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M290.M290PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.M290.M290PickupLo'
     PickupDrawScale=0.200000
     InventoryType=Class'BallisticProV55.M290Shotgun'
     RespawnTime=120.000000
     PickupMessage="You picked up the M290 shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M290.M290Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M290.M290PickupHi'
     Physics=PHYS_None
     DrawScale=0.200000
     CollisionHeight=3.500000
}
