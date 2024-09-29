//=============================================================================
// CYLOPickup.
//=============================================================================
class ZX98Pickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Ar.ARScopeMain');
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Ar.ARMain');
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Ar.ARClipMain');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.ZX98.ZX98PickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.ZX98.ZX98PickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Ar.ARScopeMain');
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Ar.ARMain');
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.Ar.ARClipMain');
}

simulated function UpdatePrecacheStaticMeshes()
{
     Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.ZX98.ZX98PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.ZX98.ZX98PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.ZX98.ZX98PickupLo'
     InventoryType=Class'BWBP_APC_Pro.ZX98AssaultRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the ZX98 Reaper Gauss Minigun."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.ZX98.ZX98PickupHi'
     Physics=PHYS_None
	DrawScale=0.250000
     CollisionHeight=4.000000
}
