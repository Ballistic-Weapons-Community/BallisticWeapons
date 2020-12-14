class WrenchPickup extends BallisticWeaponPickup
	placeable;

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.WrenchTex');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.ShieldGenerator_BLU');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Teleport_BLU');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Jumppad_BLU');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Teleport_RED');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Jumppad_RED');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Unreal2_CrateTex');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.AmmoCrate');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.BoostPad');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.EnergyWall');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.ShieldGenCore');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.ShieldOut2');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.WrenchTex');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.ShieldGenerator_BLU');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Teleport_BLU');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Jumppad_BLU');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Teleport_RED');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Jumppad_RED');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Wrench.Unreal2_CrateTex');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.AmmoCrate');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.BoostPad');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.EnergyWall');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.ShieldGenCore');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Wrench.ShieldOut2');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Wrench.WrenchPickup'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBPOtherPackPro.WrenchWarpDevice'
     RespawnTime=10.000000
     PickupMessage="You picked up the NFUD Combat Wrench."
     PickupSound=Sound'BW_Core_WeaponSound.Knife.KnifePutaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Wrench.WrenchPickup'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.000000
}
