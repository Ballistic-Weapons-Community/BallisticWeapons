//=============================================================================
// CX61 pickup
//=============================================================================
class CX61Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX61.CX61-Mag');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX61.CX61-Main');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX61.G28Cloud');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.CX61.CX61PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.CX61.CX61PickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX61.CX61-Mag');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX61.CX61-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.CX61.G28Cloud');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.CX61.CX61PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.CX61.CX61PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.CX61.CX61PickupLo'
     PickupDrawScale=0.550000
     InventoryType=Class'BWBP_OP_Pro.CX61AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the CX61 tactical rifle."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.CX61.CX61PickupHi'
     Physics=PHYS_None
     DrawScale=0.550000
     CollisionHeight=4.000000
}
