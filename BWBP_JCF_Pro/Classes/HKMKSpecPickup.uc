//=============================================================================
// HKMKSpecPickup.
//=============================================================================
class HKMKSpecPickup extends BallisticHandgunPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	//L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.HKMK.Body_Main_2D_View');
	//L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.HKMK.UnderBarrel_2D_View');
	//L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.HKMK.Silencer_2D_View');
     //L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMKSpecPickupHi');
	//L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMKSpecPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     //super.UpdatePrecacheMaterials();
	//Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.HKMK.Body_Main_2D_View');
	//Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.HKMK.UnderBarrel_2D_View');
	//Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.HKMK.Silencer_2D_View');
}

simulated function UpdatePrecacheStaticMeshes()
{
     //super.UpdatePrecacheStaticMeshes();
	//Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMKSpecPickupHi');
	//Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMKSpecPickupLo');
}

defaultproperties
{
     //LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMKSpecPickupLo'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBP_JCF_Pro.HKMKSpecPistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the HKM-26 pistol."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     //StaticMesh=StaticMesh'BWBP_JCF_Static.HKMKSpec.HKMKSpecPickupHi'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.000000
}
