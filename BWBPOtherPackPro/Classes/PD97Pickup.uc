class PD97Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD File=BWBPOtherPackTex.utx
#exec OBJ LOAD File=BWBPOtherPackStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Bloodhound.BloodhoundMain');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Bloodhound.BloodhoundAmmo');
	L.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Bloodhound.BloodhoundAcc');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Dart');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Bloodhound.BloodhoundMain');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Bloodhound.BloodhoundAmmo');
	Level.AddPrecacheMaterial(Texture'BWBPOtherPackTex.Bloodhound.BloodhoundAcc');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.PD97.PD97PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPOtherPackStatic.PD97.PD97PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware_25.OA-SMG.OA-SMG_Dart');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPOtherPackStatic.PD97.PD97PickupLo'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBPOtherPackPro.PD97Bloodhound'
     RespawnTime=10.000000
     PickupMessage="You picked up the PD-97 'Bloodhound' pistol."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBPOtherPackStatic.PD97.PD97PickupHi'
     Physics=PHYS_None
     DrawScale=0.700000
     CollisionHeight=4.000000
}
