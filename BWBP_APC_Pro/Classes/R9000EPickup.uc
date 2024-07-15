//=============================================================================
// R9000EPickup.
//=============================================================================
class R9000EPickup extends BallisticWeaponPickup
	placeable;

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.ElementalSniper.ESMain');
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.ElementalSniper.ESAmmoMain');
	L.AddPrecacheMaterial(Texture'BWBP_CC_Tex.ElementalSniper.ESScopeMain');
     L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.R9000E.R9000EPickupHi');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.R9000E.R9000EPickupLo');

}

simulated function UpdatePrecacheMaterials()
{
     super.UpdatePrecacheMaterials();
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.ElementalSniper.ESMain');
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.ElementalSniper.ESAmmoMain');
	Level.AddPrecacheMaterial(Texture'BWBP_CC_Tex.ElementalSniper.ESScopeMain');
}

simulated function UpdatePrecacheStaticMeshes()
{
     Super.UpdatePrecacheStaticMeshes();
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.R9000E.R9000EPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_CC_Static.R9000E.R9000EPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_CC_Static.R9000E.R9000EPickupLo'
     PickupDrawScale=0.500000
     InventoryType=Class'BWBP_APC_Pro.R9000ERifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the R9000E modular sniper rifle."
     PickupSound=Sound'BW_Core_WeaponSound.R78.R78Putaway'
     StaticMesh=StaticMesh'BWBP_CC_Static.R9000E.R9000EPickupHi'
     Physics=PHYS_None
     DrawScale=0.470000
     CollisionHeight=3.000000
}
