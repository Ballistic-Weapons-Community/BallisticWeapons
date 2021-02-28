//=============================================================================
// R9Pickup.
//=============================================================================
class LS14Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Spec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Impact');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.ElectroBolt');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.PlasmaMuzzleFlash2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LaserCarbine.PlasmaMuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Spec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Impact');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.ElectroBolt');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.PlasmaMuzzleFlash2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LaserCarbine.LaserCarbinePickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LaserCarbine.PlasmaMuzzleFlash');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.LaserCarbinePickup'
     PickupDrawScale=1.100000
     InventoryType=Class'BWBPRecolorsPro.LS14Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the LS-14 laser carbine."
     PickupSound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.LaserCarbinePickup'
     Physics=PHYS_None
     DrawScale=1.100000
     CollisionHeight=3.000000
}
