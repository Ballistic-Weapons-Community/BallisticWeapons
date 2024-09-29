class PD97Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD File=BWBP_OP_Tex.utx
#exec OBJ LOAD File=BWBP_OP_Static.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Bloodhound.BloodhoundMain');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Bloodhound.BloodhoundAmmo');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Bloodhound.BloodhoundAcc');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Bloodhound.BloodhoundMain');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Bloodhound.BloodhoundAmmo');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Bloodhound.BloodhoundAcc');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.PD97.PD97PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.PD97.PD97PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.PD97.PD97PickupLo'
     PickupDrawScale=1.650000
     InventoryType=Class'BWBP_OP_Pro.PD97Bloodhound'
     RespawnTime=10.000000
     PickupMessage="You picked up the PD-97 'Bloodhound' pistol."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.PD97.PD97PickupHi'
     Physics=PHYS_None
     DrawScale=2.500000
     CollisionHeight=4.000000
}
