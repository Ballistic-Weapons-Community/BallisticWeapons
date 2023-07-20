//=============================================================================
// RS8X3Pickup.
//=============================================================================
class RS8X3Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.RS8.RS8-Shiney');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BW_Core_WeaponTex.RS8.RS8-Shiney');
}
simulated function UpdatePrecacheStaticMeshes()
{
//	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.RS8.RS8Clips');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.RS8.RS8PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.RS8.RS8PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.RS8.RS8PickupLo'
     PickupDrawScale=0.210000
     InventoryType=Class'BWBP_APC_Pro.RS8X3Pistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the RS8X3 Pistol/Knife Combo."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.RS8.RS8PickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     PrePivot=(Y=-18.000000)
     CollisionHeight=4.000000
}
