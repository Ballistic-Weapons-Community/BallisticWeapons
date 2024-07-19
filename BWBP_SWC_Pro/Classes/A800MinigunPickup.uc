//=============================================================================
// XMV850Pickup.
//=============================================================================
class A800MinigunPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithHyperBlaster.Hyperblaster-MainFront');
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithHyperBlaster.Hyperblaster-MainRear');
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithHyperBlaster.Minigun_Main3_D');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73AmmoSkin');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHyperBlasterPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHyperBlasterPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithHyperBlaster.Hyperblaster-MainFront');
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithHyperBlaster.Hyperblaster-MainRear');
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithHyperBlaster.Minigun_Main3_D');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.A73.A73AmmoSkin');
}

simulated function UpdatePrecacheStaticMeshes()
{
     super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHyperBlasterPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHyperBlasterPickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHyperBlasterPickupLo'
     PickupDrawScale=0.070000
     InventoryType=Class'BWBP_SWC_Pro.A800SkrithMinigun'
     RespawnTime=20.000000
     PickupMessage="You picked up the A800 Skrith HyperBlaster"
     PickupSound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.SkrithHyperBlaster.SkrithHyperBlasterPickupHi'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=0.07
     PrePivot=(Z=35.000000)
     CollisionHeight=8.000000
}
