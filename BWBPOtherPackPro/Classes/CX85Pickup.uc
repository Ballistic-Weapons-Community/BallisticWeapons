class CX85Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD File=BWBPOtherPackTex3.utx
#exec OBJ LOAD File=BWBPOtherPackStatic3.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.CX85.CX85-ColorFront');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.CX85.CX85-ColorBack');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.CX85.CX85-Mag');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Dart');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.CX85.CX85-ColorFront');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.CX85.CX85-ColorBack');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex3.CX85.CX85-Mag');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic3.CX85.CX85StaticHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic3.CX85.CX85StaticLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Dart');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic3.CX85.CX85StaticLo'
     InventoryType=Class'BWBPOtherPackPro.CX85AssaultWeapon'
     RespawnTime=20.000000
     PickupMessage="You picked up the CX85 assault weapon."
     PickupSound=Sound'BallisticSounds2.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic3.CX85.CX85StaticHi'
     Physics=PHYS_None
     DrawScale=1.500000
     CollisionHeight=4.000000
}
