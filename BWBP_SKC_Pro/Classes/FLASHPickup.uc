//=============================================================================
// FLASHPickup.
//=============================================================================
class FLASHPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Flash.FLASH-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Flash.FLASH-Rocket');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Flash.FLASH-Scope');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Flash.FLASH-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Flash.FLASH-Rocket');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Flash.FLASH-Scope');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Flash.FLASHAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Flash.FLASHPickupHi');
     Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Flash.FLASHPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.Flash.FLASHPickupLo'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBP_SKC_Pro.FLASHLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the AT40 'STREAK' incendiary rocket launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Flash.FLASHPickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=6.000000
}
