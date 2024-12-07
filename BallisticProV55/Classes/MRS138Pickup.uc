//=============================================================================
// MRS138Pickup.
//=============================================================================
class MRS138Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.MRS138.MRS138Shiney');
	L.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.MRS138.MRS138HeatShiney');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRS138.MRS138Shell');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.MRS138.MRS138Shiney');
	Level.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.MRS138.MRS138HeatShiney');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRS138.MRS138Shell');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRS138.MRS138PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRS138.MRS138PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.MRS138.MRS138PickupLo'
     PickupDrawScale=0.190000
     InventoryType=Class'BallisticProV55.MRS138Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MRS-138 tactical shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRS138.MRS138PickupHi'
     Physics=PHYS_None
     DrawScale=0.200000
     PrePivot=(Y=-18.000000)
     CollisionHeight=3.000000
}
