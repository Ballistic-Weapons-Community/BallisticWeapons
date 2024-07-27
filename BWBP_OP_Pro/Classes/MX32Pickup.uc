class MX32Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=ONSstructureTextures.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload.
// Gametypes needing to do this don't use pickups. Don't preload pickup and ammo assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.MX32.MX32-Main-D');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.MX32.MX32-Attach-D');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.MX32.MX32PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.MX32.MX32PickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.MX32.MX32-Main-D');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.MX32.MX32-Attach-D');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.MX32.MX32PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.MX32.MX32PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.MX32.MX32PickupLo'
     InventoryType=Class'BWBP_OP_Pro.MX32Weapon'
     RespawnTime=20.000000
     PickupMessage="You picked up the MX-32 Rocket Machine Gun."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.MX32.MX32PickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
