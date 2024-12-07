//=============================================================================
// FG50Pickup.
//=============================================================================
class FG50Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FG50.FG50-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FG50.FG50-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FG50.FG50-Screen');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Stock');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FG50.FG50PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FG50.FG50PickupLo');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FG50.FG50AmmoPickup');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FG50.FG50-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FG50.FG50-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FG50.FG50-Screen');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.FSG50.FSG-Stock');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FG50.FG50PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FG50.FG50PickupLo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.FG50.FG50AmmoPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.FG50.FG50PickupLo'
     InventoryType=Class'BWBP_SKC_Pro.FG50MachineGun'
     RespawnTime=20.000000
     PickupMessage="You picked up the FG50 machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.FG50.FG50PickupHi'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.000000
}
