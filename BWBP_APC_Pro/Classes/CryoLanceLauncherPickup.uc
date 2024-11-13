//=============================================================================
// CryoLanceLauncherPickup
//=============================================================================
class CryoLanceLauncherPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CryoCannon.Cannon_Cryo_D1');
    L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CryoLance.CryoCannonPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CryoLance.CryoCannonPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
    super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CryoCannon.Cannon_Cryo_D1');
}

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CryoLance.CryoCannonPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CryoLance.CryoCannonPickupLo');
}

defaultproperties
{
    bOnSide=False
	LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.CryoLance.CryoCannonPickupLo'
    InventoryType=Class'BWBP_APC_Pro.CryoLanceLauncher'
    RespawnTime=20.000000
    PickupMessage="You picked up the Cryo Lance"
    PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
    StaticMesh=StaticMesh'BWBP_APC_Static.CryoLance.CryoCannonPickupHi'
    Physics=PHYS_None
	DrawScale=0.400000
    CollisionHeight=4.000000
}
