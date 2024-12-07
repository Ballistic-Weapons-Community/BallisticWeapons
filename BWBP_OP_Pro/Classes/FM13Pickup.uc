//=============================================================================
// FM13Pickup.
//=============================================================================
class FM13Pickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.FM13.DragonMain');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.FM13.DragonMiscMain');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Dragon.DragonPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Dragon.DragonPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.FM13.DragonMain');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.FM13.DragonMiscMain');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Dragon.DragonPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Dragon.DragonPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Dragon.DragonPickupLo'
     InventoryType=Class'BWBP_OP_Pro.FM13Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the FM13 Dragon shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Dragon.DragonPickupHi'
     Physics=PHYS_None
     DrawScale=0.15000
     CollisionHeight=3.000000
}
