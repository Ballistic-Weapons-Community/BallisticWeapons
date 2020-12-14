//=============================================================================
// SARPickup.
//=============================================================================
class SARPickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SAR.SARSkin');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.SAR.SARSkin');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.SAR.SARClips');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.SAR.SARPickup-Hi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.SAR.SARPickup-Lo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.SAR.SARPickup-Lo'
     PickupDrawScale=0.140000
     InventoryType=Class'BallisticProV55.SARAssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the Sub-Assault Rifle 12."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.SAR.SARPickup-Hi'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
