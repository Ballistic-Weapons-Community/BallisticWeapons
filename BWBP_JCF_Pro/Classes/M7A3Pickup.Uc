//=============================================================================
// SARPickup.
//=============================================================================
class M7A3Pickup extends BallisticWeaponPickup
	placeable;

#EXEC OBJ LOAD File="BWBP_JCF_Tex.utx"
#EXEC OBJ LOAD File="BWBP_JCF_Static"

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.M7A3.M7A3_D');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M7A3.M7A3PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M7A3.M7A3PickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.M7A3.M7A3_D');
}

simulated function UpdatePrecacheStaticMeshes()
{
     super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M7A3.M7A3PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M7A3.M7A3PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.M7A3.M7A3PickupLo'
     PickupDrawScale=0.260000
     InventoryType=Class'BWBP_JCF_Pro.M7A3AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the M7A3 Assault Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.M7A3.M7A3PickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.000000
}
