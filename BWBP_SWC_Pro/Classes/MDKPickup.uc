//=============================================================================
// MDKPickup.
//=============================================================================
class MDKPickup extends BallisticHandgunPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.Main_2D_View');
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.Attachments_2D_View');
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.Silencer_2D_View');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.MDK.MDKPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.MDK.MDKPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.Main_2D_View');
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.Attachments_2D_View');
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.Silencer_2D_View');
}

simulated function UpdatePrecacheStaticMeshes()
{
     super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.MDK.MDKPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.MDK.MDKPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SWC_Static.MDK.MDKPickupLo'
     PickupDrawScale=0.525000
     InventoryType=Class'BWBP_SWC_Pro.MDKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MDK Modular SubMachine Gun."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.MDK.MDKPickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}