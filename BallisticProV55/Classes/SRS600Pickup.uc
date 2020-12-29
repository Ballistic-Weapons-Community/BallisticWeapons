class SRS600Pickup extends SRS900Pickup
	placeable;
	
//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SRS900.SRS900Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SRS900.SRS900Scope');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SRS900.SRS900Ammo');
}
	
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SRS900.SRS900Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SRS900.SRS900Scope');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SRS900.SRS900Ammo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.SRS900.SRS900Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.SRS900.SRS900PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.SRS900.SRS900PickupLo');
}

defaultproperties
{
     InventoryType=Class'BallisticProV55.SRS600Rifle'
     PickupMessage="You picked up the SRS-600 enhanced battle rifle."
}
