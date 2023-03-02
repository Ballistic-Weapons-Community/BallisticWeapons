//=============================================================================
// AK47Pickup.
//=============================================================================
class ParticleStreamPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_OP_Static.usx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.ProtonPack.Proton_gun_SH1');
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.ProtonPack.Proton_pack_SH_1');
	
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.ProtonPack.Proton_Pack_Static');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.ProtonPack.Proton_Pack_Static_Test');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.ProtonPack.Proton_gun_SH1');
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.ProtonPack.Proton_pack_SH_1');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.ProtonPack.Proton_Pack_Static');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.ProtonPack.Proton_Pack_Static_Test');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.ProtonPack.proton_pack_static'
     PickupDrawScale=0.750000
     InventoryType=Class'BWBP_APC_Pro.ParticleStreamer'
     RespawnTime=20.000000
     PickupMessage="You picked up the mk.II E90-N particle accelerator."
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.ProtonPack.proton_pack_static'
     Physics=PHYS_None
     DrawScale=0.750000
     CollisionHeight=4.500000
	 Skins(1)=Shader'BWBP_OP_Tex.ProtonPack.proton_pack_SH_1'
}
