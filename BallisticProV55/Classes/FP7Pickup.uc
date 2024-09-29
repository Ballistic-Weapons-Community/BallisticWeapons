//=============================================================================
// FP7Pickup.
//=============================================================================
class FP7Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.FP7.FP7Grenade');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.FlameParts');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.FP7Clip');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.FP7.FP7Proj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.FP7.FP7Grenade');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.FlameParts');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.BlazingSubdivide');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.FP7Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.FP7.FP7Proj');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.FP7.FP7PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.FP7.FP7PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.FP7.FP7PickupLo'
     PickupDrawScale=0.500000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.FP7Grenade'
     RespawnTime=20.000000
     PickupMessage="You picked up the FP7 grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.FP7.FP7PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
	 DrawScale=0.900000
     CollisionHeight=5.600000
}
