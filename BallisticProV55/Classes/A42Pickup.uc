//=============================================================================
// A42Pickup.
//=============================================================================
class A42Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A42.A42_Exp');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A42Scorch');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile2');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42MuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A42.A42_Exp');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.A42Scorch');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A73MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.GunFire.A42Projectile2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42PickupLo');
}

function SetWeaponStay()
{
	bWeaponStay = false;
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.A42.A42PickupLo'
     PickupDrawScale=0.187000
     InventoryType=Class'BallisticProV55.A42SkrithPistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the A42 Skrith sidearm."
     PickupSound=Sound'BW_Core_WeaponSound.A42.A42-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.A42.A42PickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.500000
}
