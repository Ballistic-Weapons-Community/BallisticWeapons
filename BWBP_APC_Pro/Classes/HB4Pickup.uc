//=============================================================================
// MGLPickup.
//=============================================================================
class HB4Pickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.HoloBlaster.HoloBlaster_Main_Tex');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.HoloBlaster.HoloBlasterPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.HoloBlaster.HoloBlasterPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.HoloBlaster.HoloBlaster_Main_Tex');
}

simulated function UpdatePrecacheStaticMeshes()
{
     Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.HoloBlaster.HoloBlasterPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.HoloBlaster.HoloBlasterPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.HoloBlaster.HoloBlasterPickupLo'
     InventoryType=Class'BWBP_APC_Pro.HB4GrenadeBlaster'
     RespawnTime=120.000000
     PickupMessage="You picked up the HB4 Electro Grenade Blaster."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_APC_Static.HoloBlaster.HoloBlasterPickupHi'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=3.000000
}
