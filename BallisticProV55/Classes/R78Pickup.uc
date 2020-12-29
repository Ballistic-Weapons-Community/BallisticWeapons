//=============================================================================
// R78Pickup.
//=============================================================================
class R78Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.RifleSkin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.ScopeSkin');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.RifleSkin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.R78.ScopeSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.R78Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.R78.R78PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.R78.R78PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.R78.R78PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BallisticProV55.R78Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the R78A1 explosive sniper rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.R78.R78PickupHi'
     Physics=PHYS_None
     DrawScale=0.470000
     CollisionHeight=3.000000
}
