//=============================================================================
// MarlinPickup.
//=============================================================================
class MarlinPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Ammo');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Main');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Shell');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Specmask');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Ammo');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Main');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Shell');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Marlin.Marlin_Specmask');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Marlin.Marlin-AmmoBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Marlin.Marlin-PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Marlin.Marlin-PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.Marlin.Marlin-PickupLo'
     PickupDrawScale=0.210000
     InventoryType=Class'BallisticProV55.MarlinRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the Redwood 6000 'DeerMaster'."
     PickupSound=Sound'BallisticSounds2.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.Marlin.Marlin-PickupHi'
     Physics=PHYS_None
     DrawScale=0.250000
     CollisionHeight=3.000000
}
