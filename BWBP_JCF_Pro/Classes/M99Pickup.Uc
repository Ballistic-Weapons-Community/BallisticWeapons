//=============================================================================
// R78Pickup.
//=============================================================================
class M99Pickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.M99.M99_A');
 	L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.M99.M99_B');    
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M99.M99PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M99.M99PickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.M99.M99_A');
	Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.M99.M99_B');
}

simulated function UpdatePrecacheStaticMeshes()
{
     super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M99.M99PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.M99.M99PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.M99.M99PickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_JCF_Pro.M99Rifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the M99-ECS Anti Material Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.M99.M99PickupHi'
     Physics=PHYS_None
     DrawScale=0.270000
     CollisionHeight=3.000000
}
