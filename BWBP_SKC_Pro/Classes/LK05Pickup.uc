//=============================================================================
// red bullets.
//=============================================================================
class LK05Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M30A2.M30A2-Laser');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-EOTech-RDS');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Grip');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-LAM');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Mag');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Receiver');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Silencer');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Stock');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-VertFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M30A2.M30A2-Laser');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-EOTech-RDS');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Grip');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-LAM');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Mag');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Receiver');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Silencer');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-Stock');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.LK05.LK05-VertFlash');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.LK05.LK05Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.LK05.LK05Pickup'
     InventoryType=Class'BWBP_SKC_Pro.LK05Carbine'
     RespawnTime=20.000000
     PickupMessage="You picked up the LK-05 advanced carbine."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.LK05.LK05Pickup'
     Physics=PHYS_None
	 Drawscale=0.25
     CollisionHeight=4.000000
}
