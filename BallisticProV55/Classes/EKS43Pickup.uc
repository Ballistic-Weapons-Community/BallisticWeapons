//=============================================================================
// EKS43Pickup.
//=============================================================================
class EKS43Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.EKS43.Katana');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.EKS43.Katana');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.EKS43.KatanaPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.EKS43.KatanaPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.EKS43.KatanaPickupLo'
     PickupDrawScale=0.200000
     InventoryType=Class'BallisticProV55.EKS43Katana'
     RespawnTime=10.000000
     PickupMessage="You picked up the EKS-43 katana."
     PickupSound=Sound'BW_Core_WeaponSound.EKS43.EKS-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.EKS43.KatanaPickupHi'
     Physics=PHYS_None
     DrawScale=0.150000
     CollisionHeight=4.000000
}
