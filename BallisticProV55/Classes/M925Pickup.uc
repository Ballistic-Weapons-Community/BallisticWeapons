//=============================================================================
// M925Pickup.
//=============================================================================
class M925Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925Small');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925AmmoBox');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925HeatShield');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925Small');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925AmmoBox');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.M925.M925HeatShield');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M925AmmoBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M925.M925PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.M925.M925PickupLo'
     PickupDrawScale=0.250000
     StandUp=(Y=0.800000)
     InventoryType=Class'BallisticProV55.M925Machinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the M925 machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M925.M925-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M925.M925PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.160000
     TransientSoundVolume=0.600000
     CollisionHeight=8.000000
}
