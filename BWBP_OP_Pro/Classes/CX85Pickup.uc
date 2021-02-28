class CX85Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD File=BWBP_OP_Tex.utx
#exec OBJ LOAD File=BWBP_OP_Static.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX85.CX85-ColorFront');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX85.CX85-ColorBack');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX85.CX85-Mag');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX85.CX85-ColorFront');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX85.CX85-ColorBack');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX85.CX85-Mag');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.CX85.CX85StaticHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.CX85.CX85StaticLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.CX85.CX85StaticLo'
     InventoryType=Class'BWBP_OP_Pro.CX85AssaultWeapon'
     RespawnTime=20.000000
     PickupMessage="You picked up the CX85 assault weapon."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.CX85.CX85StaticHi'
     Physics=PHYS_None
     DrawScale=1.500000
     CollisionHeight=4.000000
}
