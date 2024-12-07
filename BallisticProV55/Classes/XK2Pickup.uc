//=============================================================================
// XK2Pickup.
//=============================================================================
class XK2Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XK2.XK2Skin');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XK2.XK2Skin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.XK2Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XK2.XK2PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XK2.XK2PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.XK2.XK2PickupLo'
     PickupDrawScale=0.250000
     InventoryType=Class'BallisticProV55.XK2SubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the XK2 submachine gun."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.XK2.XK2PickupHi'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=4.000000
}
