//=============================================================================
// NRP57Pickup.
//=============================================================================
class NRP57Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NRP57.Grenade');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.GrenadeClip');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NRP57.Pineapple');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.NRP57.Grenade');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.GrenadeClip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NRP57.Pineapple');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NRP57.NRP57PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.NRP57.NRP57PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.NRP57.NRP57PickupLo'
     PickupDrawScale=0.200000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.NRP57Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the NRP-57 grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.NRP57.NRP57PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=5.600000
}
