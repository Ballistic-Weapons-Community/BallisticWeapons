//=============================================================================
// G5Pickup.
//=============================================================================
class RGPXPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.RGP-X350.RGP_Launcher_D');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350PickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.RGP-X350.RGP_Launcher_D');
}

simulated function UpdatePrecacheStaticMeshes()
{
     super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350PickupLo'
     PickupDrawScale=0.300000
     InventoryType=Class'BWBP_JCF_Pro.RGPXBazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the RGK-350 H-V Flak Bazooka."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350PickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=6.000000
}
