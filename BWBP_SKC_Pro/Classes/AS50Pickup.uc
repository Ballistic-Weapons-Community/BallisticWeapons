//=============================================================================
// AS50Pickup.
//=============================================================================
class AS50Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Scope');	
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Stock');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Scope');	
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Stock');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FSSG50.FSSG50PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FSSG50.FSSG50AmmoPickup');

}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.FSSG50.FSSG50PickupHi'
     PickupDrawScale=0.750000
     MaxDesireability=0.750000
     InventoryType=Class'BWBP_SKC_Pro.AS50Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the FSSG-50 marksman rifle."
     PickupSound=Sound'BW_Core_WeaponSound.MRL.MRL-BigOn'
     StaticMesh=StaticMesh'BWBP_SKC_Static.FSSG50.FSSG50PickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     PrePivot=(Y=-15.000000)
     CollisionHeight=3.000000
}
