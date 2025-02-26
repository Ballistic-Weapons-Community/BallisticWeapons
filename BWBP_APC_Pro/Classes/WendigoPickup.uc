//=============================================================================
// WendigoPickup.
//=============================================================================
class WendigoPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	 L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.Wendigo.Wendigo_Body_Main');
	 L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupHi');
	 L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	 Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.Wendigo.Wendigo_Body_Main');
     Super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	 Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupHi');
	 Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupLo');
     Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupLo'
     InventoryType=Class'BWBP_APC_Pro.WendigoSMG'
     RespawnTime=20.000000
     PickupMessage="You picked up the Wendigo SMG."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_APC_Static.Wendigo.WendigoPickupHi'
     Physics=PHYS_None
     CollisionHeight=4.000000
}
