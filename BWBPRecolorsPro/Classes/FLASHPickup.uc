//=============================================================================
// FLASHPickup.
//=============================================================================
class FLASHPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_TexExp.utx
#exec OBJ LOAD FILE=BWBP_SKC_StaticExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Flash.FLASH-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Flash.FLASH-Rocket');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Flash.FLASH-Scope');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Flash.FLASH-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Flash.FLASH-Rocket');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_TexExp.Flash.FLASH-Scope');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.Flash.FLASHAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_StaticExp.Flash.FLASHPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_StaticExp.Flash.FLASHPickup'
     PickupDrawScale=0.600000
     InventoryType=Class'BWBPRecolorsPro.FLASHLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the AT40 'STREAK' incendiary rocket launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_StaticExp.Flash.FLASHPickup'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=6.000000
}
