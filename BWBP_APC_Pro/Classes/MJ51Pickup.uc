//=============================================================================
// MJ51Pickup.
//=============================================================================
class MJ51Pickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.M4A1.M4-Main');
 	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.MJ51.MJ51PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.MJ51.MJ51PickupLo');   
}

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.M4A1.M4-Main');
    Super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.MJ51.MJ51PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.MJ51.MJ51PickupLo');
    Super.UpdatePrecacheStaticMeshes();
} 

defaultproperties
{
    LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.MJ51.MJ51PickupLo'
    InventoryType=Class'BWBP_APC_Pro.MJ51Carbine'
    RespawnTime=20.0000000
    PickupMessage="You picked up the MJ51 Carbine"
    PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
    StaticMesh=StaticMesh'BWBP_APC_Static.MJ51.MJ51PickupHi'
    Physics=PHYS_None
    DrawScale=0.2600000
    CollisionHeight=4.0000000
}