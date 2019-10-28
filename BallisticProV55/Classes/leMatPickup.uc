//=============================================================================
// leMatPickup.
//=============================================================================
class leMatPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.leMat.leMat_Main');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.leMat.leMat_Shield');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.leMat.leMat_Speed');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.leMat.leMat_Main');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.leMat.leMat_Shield');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.leMat.leMat_Speed');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.leMat.leMatAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.leMat.leMatPickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.leMat.leMatPickupHi');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.leMat.leMatPickupLo'
     PickupDrawScale=0.270000
     InventoryType=Class'BallisticProV55.leMatRevolver'
     RespawnTime=10.000000
     PickupMessage="You picked up the Wilson 41 revolver."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.leMat.leMatPickupHi'
     Physics=PHYS_None
     DrawScale=0.480000
     CollisionHeight=4.000000
}
