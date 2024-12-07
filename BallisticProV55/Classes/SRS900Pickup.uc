//=============================================================================
// SRS900Pickup.
//=============================================================================
class SRS900Pickup extends BallisticWeaponPickup
	placeable;

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
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.SRS900.SRS900PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.SRS900Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the SRS-900 battle rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.SRS900.SRS900PickupHi'
     Physics=PHYS_None
     DrawScale=0.380000
     CollisionHeight=3.000000
}
