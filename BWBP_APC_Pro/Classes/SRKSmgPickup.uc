//=============================================================================
// MJ51Pickup.
//=============================================================================
class SRKSmgPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	 L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMain1');
	 L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMain2');
	 L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMain3');
	 L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMuzzMain');
	 L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGRenCamo5');
     L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGBarrelMain');
     L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.SRX.SRX-Holo');
     L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGPlatingMain');
     L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SRX-RadGrenade');
     L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M4A1.M4-Ord');
	 L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupHi');
	 L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	 Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMain1');
	 Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMain2');
	 Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMain3');
	 Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGMuzzMain');
	 Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGRenCamo5');
     Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGBarrelMain');
     Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.SRX.SRX-Holo');
     Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SMGPlatingMain');
     Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.SRXSmg.SRX-RadGrenade');
     Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M4A1.M4-Ord');
     Super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
	 Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupHi');
	 Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupLo');
     Super.UpdatePrecacheStaticMeshes();
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupLo'
     InventoryType=Class'BWBP_APC_Pro.SRKSubMachinegun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SRK-205 Sub-Machine Gun"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_APC_Static.SPXSmg.SPXSmgPickupHi'
     Physics=PHYS_None
     DrawScale=0.100000
     CollisionHeight=4.000000
}
