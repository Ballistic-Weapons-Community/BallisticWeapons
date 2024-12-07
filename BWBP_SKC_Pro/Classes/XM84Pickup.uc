//=============================================================================
// XM84Pickup.
//=============================================================================
class XM84Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XM84.XM84-MainDark');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM84.XM84Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM84.XM84PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM84.XM84PickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.XM84.XM84-MainDark');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM84.XM84Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM84.XM84Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM84.XM84PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.XM84.XM84PickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.XM84.XM84PickupLo'
     PickupDrawScale=1.000000
     bWeaponStay=False
     InventoryType=Class'BWBP_SKC_Pro.XM84Flashbang'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM84 heavy tech grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.XM84.XM84PickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=1.600000
     CollisionHeight=5.600000
}
