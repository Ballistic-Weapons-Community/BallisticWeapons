//=============================================================================
// BX5Pickup.
//=============================================================================
class BX5Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.BX5.BX5Skin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Effects.VBlast');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Effects.HBlast');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MineSBase2');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MineSProj2');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MineV2');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.BX5.BX5Skin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Effects.VBlast');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Effects.HBlast');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MineSBase2');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MineSProj2');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MineV2');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MinePickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.BX5.MinePickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.BX5.MinePickupLo'
     PickupDrawScale=0.300000
     bWeaponStay=False
     InventoryType=Class'BallisticProV55.BX5Mine'
     RespawnTime=20.000000
     PickupMessage="You picked up the BX5-SM land mine."
     PickupSound=Sound'BW_Core_WeaponSound.BX5.BX5-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.BX5.MinePickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.650000
     CollisionHeight=5.600000
}
