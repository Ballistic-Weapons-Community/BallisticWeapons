//=============================================================================
// R9000EPickup.
//=============================================================================
class R9000EPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.ElementalSniper.ESMain');
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.ElementalSniper.ESAmmoMain');
	L.AddPrecacheMaterial(Texture'BWBP_APC_Tex.ElementalSniper.ESScopeMain');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.R9000E.R9000EPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.R9000E.R9000EPickupLo');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.ElementalSniper.ESMain');
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.ElementalSniper.ESAmmoMain');
	Level.AddPrecacheMaterial(Texture'BWBP_APC_Tex.ElementalSniper.ESScopeMain');
     Super.UpdatePrecacheMaterials();    
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.R9000E.R9000EPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_APC_Static.R9000E.R9000EPickupLo');
     Super.UpdatePrecacheStaticMeshes();    
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_APC_Static.R9000E.R9000EPickupLo'
     PickupDrawScale=0.480000
     InventoryType=Class'BWBP_APC_Pro.R9000ERifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the R9000E modular sniper rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_APC_Static.R9000E.R9000EPickupHi'
     Physics=PHYS_None
     DrawScale=0.350000
     CollisionHeight=3.000000
}
