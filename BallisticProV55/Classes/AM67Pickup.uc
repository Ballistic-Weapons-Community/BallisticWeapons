//=============================================================================
// AM67Pickup.
//=============================================================================
class AM67Pickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.AM67.AM67Main');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.AM67.AM67Main');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.AM67.AM67Clips');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.AM67.PickupLD'
     PickupDrawScale=0.190000
     InventoryType=Class'BallisticProV55.AM67Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the AM67 assault pistol."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.AM67.PickupLD'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Y=-26.000000)
     CollisionHeight=4.000000
}
