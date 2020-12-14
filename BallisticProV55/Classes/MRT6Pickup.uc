//=============================================================================
// MRT6Pickup.
//=============================================================================
class MRT6Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRT6.MRT6Skin');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Brass.Cart_Shotgun2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6MuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRT6.MRT6Skin');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Brass.Cart_Shotgun2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.MRT6Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6PickupLo'
     PickupDrawScale=0.450000
     InventoryType=Class'BallisticProV55.MRT6Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MRT-6 shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.MRT6.MRT6Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6PickupHi'
     Physics=PHYS_None
     DrawScale=0.800000
     CollisionHeight=3.500000
}
