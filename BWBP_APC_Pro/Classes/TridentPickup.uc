//=============================================================================
// TridentPickup
//=============================================================================
class TridentPickup extends BallisticWeaponPickup
	placeable;

#EXEC OBJ LOAD File="BWBP_APC_Static.usx"

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CruMG.MGMain');
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CruMG.MGAmmoMain');
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CruMG.MGSkullMain');
    L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CruMG.CruMGPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CruMG.CruMGPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
    super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CruMG.MGMain');
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CruMG.MGAmmoMain');
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.CruMG.MGSkullMain');
}

simulated function UpdatePrecacheStaticMeshes()
{
    Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CruMG.CruMGPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.CruMG.CruMGPickupLo');
}

defaultproperties
{
    bOnSide=False
	LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.CruMG.CruMGPickupLo'
    InventoryType=Class'BWBP_APC_Pro.TridentMachinegun'
    RespawnTime=20.000000
    PickupMessage="You picked up the Trident Splitter Machinegun."
    PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
    StaticMesh=StaticMesh'BWBP_APC_Static.CruMG.CruMGPickupHi'
    Physics=PHYS_None
	DrawScale=0.400000
    CollisionHeight=4.000000
}
