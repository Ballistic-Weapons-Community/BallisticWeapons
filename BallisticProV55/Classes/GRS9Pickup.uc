//=============================================================================
// GRS9Pickup.
//=============================================================================
class GRS9Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Brass.Cart_Silver');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Glock.Glock_Main');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Glock.Glock_SpecMask');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Glock.LaserBeam');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Brass.Cart_Silver');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Glock.Glock_Main');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Glock.Glock_SpecMask');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Glock.LaserBeam');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Glock.Glock-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Glock.Glock-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Glock.Glock-Ammo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.Glock.Glock-LD'
     PickupDrawScale=0.160000
     InventoryType=Class'BallisticProV55.GRS9Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the GRS-9 pistol."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.Glock.Glock-HD'
     Physics=PHYS_None
     DrawScale=0.340000
     PrePivot=(Y=-40.000000)
     CollisionHeight=4.000000
}
