//=============================================================================
// SPASPickup.
//=============================================================================
class SPASPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.SPAS.SPASShort_Main_D');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.SPAS.SPASPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.SPAS.SPASPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_JCF_Tex.SPAS.SPASShort_Main_D');
}

simulated function UpdatePrecacheStaticMeshes()
{
     super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.SPAS.SPASPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_JCF_Static.SPAS.SPASPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_JCF_Static.SPAS.SPASPickupLo'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_JCF_Pro.SPASShotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SP-12 Compact Shotgun"
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_JCF_Static.SPAS.SPASPickupHi'
     Physics=PHYS_None
     CollisionHeight=3.000000
	 DrawScale=0.100000
}
