//=============================================================================
// MDKPickup.
//=============================================================================
class MDKPickup extends BallisticHandgunPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.MDK_Smg_Main');
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.MDK_Attachments_Main');
	L.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.MDK_Silencer_Main');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.MDK.MDKPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SWC_Static.MDK.MDKPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.MDK_Smg_Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.MDK_Attachments_Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SWC_Tex.MDK.MDK_Silencer_Main');
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
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SWC_Pro.MDKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the MDK Modular SubMachine Gun."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_SWC_Static.MDK.MDKPickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}
