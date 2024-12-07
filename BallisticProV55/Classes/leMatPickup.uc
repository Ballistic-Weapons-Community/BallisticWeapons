//=============================================================================
// leMatPickup.
//=============================================================================
class leMatPickup extends BallisticHandgunPickup
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
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.leMat.leMat_Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.leMat.leMat_Shield');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.leMat.leMat_Speed');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.leMat.leMat_Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.leMat.leMat_Shield');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.leMat.leMat_Speed');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.leMat.leMatAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.leMat.leMatPickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.leMat.leMatPickupHi');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.leMat.leMatPickupLo'
     PickupDrawScale=0.270000
     InventoryType=Class'BallisticProV55.leMatRevolver'
     RespawnTime=10.000000
     PickupMessage="You picked up the Wilson 41 revolver."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.leMat.leMatPickupHi'
     Physics=PHYS_None
     DrawScale=0.330000
     CollisionHeight=4.000000
}
