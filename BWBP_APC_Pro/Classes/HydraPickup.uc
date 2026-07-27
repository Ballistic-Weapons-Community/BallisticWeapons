//=============================================================================
// Hydraickup.
//=============================================================================
class HydraPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.RL.RL_Main');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.RL.CruRLPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.RL.CruRLPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.RL.RL_Main');
     Super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.RL.CruRLPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.RL.CruRLPickupLo');
     Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.RL.CruRLPickupLo'
     PickupDrawScale=0.380000
     InventoryType=Class'BWBP_APC_Pro.HydraBazooka'
     RespawnTime=60.000000
     PickupMessage="You picked up the Hydra missile launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_APC_Static.RL.CruRLPickupHi'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=6.000000
}
