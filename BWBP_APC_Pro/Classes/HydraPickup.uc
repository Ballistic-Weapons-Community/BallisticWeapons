//=============================================================================
// Hydraickup.
//=============================================================================
class HydraPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.RL.RL_Main');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.RL.CruRLPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.RL.CruRLPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.RL.RL_Main');
}

simulated function UpdatePrecacheStaticMeshes()
{
     Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.RL.CruRLPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.RL.CruRLPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.RL.CruRLPickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_APC_Pro.HydraBazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the Hydra missile launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.RL.CruRLPickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=6.000000
}
