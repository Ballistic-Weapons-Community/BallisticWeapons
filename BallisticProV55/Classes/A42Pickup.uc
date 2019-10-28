//=============================================================================
// A42Pickup.
//=============================================================================
class A42Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.A42.A42_Exp');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A42Scorch');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile2');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42MuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A42.A42_Exp');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A42Scorch');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42PickupLo');
}

function SetWeaponStay()
{
	bWeaponStay = false;
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticHardware2.A42.A42PickupLo'
     PickupDrawScale=0.187000
     InventoryType=Class'BallisticProV55.A42SkrithPistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the A42 Skrith sidearm."
     PickupSound=Sound'BallisticSounds2.A42.A42-Putaway'
     StaticMesh=StaticMesh'BallisticHardware2.A42.A42PickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.500000
}
