//=============================================================================
// XMV850Pickup.
//=============================================================================
class XMV850Pickup extends BallisticWeaponPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XMV850.XMV850_Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XMV850.XMV850_Barrels');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XMV850.XMV850_BackPack');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850backpack');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XMV850.XMV850_Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XMV850.XMV850_Barrels');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.XMV850.XMV850_BackPack');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850PickupLD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850PickupHD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850backpack');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850AmmoPiickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850PickupLD'
     PickupDrawScale=0.350000
     InventoryType=Class'BallisticProV55.XMV850Minigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the XMV-850 minigun."
     PickupSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.XMV850.XMV850PickupHD'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.300000
     PrePivot=(Z=35.000000)
     CollisionHeight=8.000000
}
