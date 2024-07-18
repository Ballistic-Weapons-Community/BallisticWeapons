//=============================================================================
// M353Pickup.
//=============================================================================
class PKMPickup extends BallisticWeaponPickup
	placeable;
	
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.PKM.PKM_Main');
  	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AK490.AK490-Misc');   
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.PKMA.PKMAPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.PKMA.PKMAPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.PKM.PKM_Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AK490.AK490-Misc');
}

simulated function UpdatePrecacheStaticMeshes()
{
     Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.PKMA.PKMAPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.PKMA.PKMAPickupLo');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.PKMA.PKMAPickupLo'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBP_APC_Pro.PKMMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the PKMA machinegun."
     PickupSound=Sound'BW_Core_WeaponSound.M353.M353-Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.PKMA.PKMAPickupHi'
     Physics=PHYS_None
     DrawScale=0.650000
     CollisionHeight=12.000000
}
