//=============================================================================
// TyphonPDWPickup.
//=============================================================================
class TyphonPDWPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-SpecMap');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-Mag');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-SpecMapMag');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Cart_Puma');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-SpecMap');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-Mag');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Typhon-SpecMapMag');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Typhon.Cart_Puma');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Typhon.TyphonPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Puma.PumaShield');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Puma.ShieldShard');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.A42.A42MuzzleFlash');
}


defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.Typhon.TyphonPickup'
     PickupDrawScale=0.200000
     InventoryType=Class'BWBP_SKC_Pro.TyphonPDW'
     RespawnTime=10.000000
     PickupMessage="You picked up the LRX-5 'Typhon' Pulse PDW."
     PickupSound=Sound'BWBP_SKC_Sounds.PUMA.PUMA-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Typhon.TyphonPickup'
     Physics=PHYS_None
     DrawScale=0.220000
     CollisionHeight=4.000000
}
