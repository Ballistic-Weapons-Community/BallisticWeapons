//=============================================================================
// A73Pickup.
//=============================================================================
class SkrithStaffPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=..\Textures\BWBP_SWC_Tex.utx
#exec OBJ LOAD FILE=..\StaticMeshes\BWBP_SWC_Static.usx


simulated function UpdatePrecacheMaterials()
{
	//Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithStaff.SkrithStaffBladeSkin');
	//Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithStaff.SkrithStaffSkinA');
	//Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.SkrithStaff.SkrithStaffSkinB');
}

defaultproperties
{
     //LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.SkrithStaff.SkrithStaff_Weapon'
     InventoryType=Class'BWBP_SWC_Pro.SkrithStaff'
     RespawnTime=20.000000
     PickupMessage="You picked up the Skrith Shillelagh"
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     //StaticMesh=StaticMesh'BWBP_SWC_Static.SkrithStaff.SkrithStaff_Weapon'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.500000
}
