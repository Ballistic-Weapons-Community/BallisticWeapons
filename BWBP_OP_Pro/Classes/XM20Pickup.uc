//=============================================================================
// R9Pickup.
//=============================================================================
class XM20Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.XM20P.XM20ShinyP');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Impact');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.ElectroBolt');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.PlasmaMuzzleFlash2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LaserCarbine.PlasmaMuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.XM20P.XM20ShinyP');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.LS14-Impact');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.ElectroBolt');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LS14.PlasmaMuzzleFlash2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.XM20P.XM20P-Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LaserCarbine.PlasmaMuzzleFlash');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.XM20P.XM20P-Pickup'
     PickupDrawScale=1.100000
     InventoryType=Class'BWBP_OP_Pro.XM20AutoLas'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM20-P prototype laser rifle."
     PickupSound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Pickup'
     StaticMesh=StaticMesh'BWBP_OP_Static.XM20P.XM20P-Pickup'
     Physics=PHYS_None
     DrawScale=1.00000
     CollisionHeight=3.500000
}
