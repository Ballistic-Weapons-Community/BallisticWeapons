//=============================================================================
// DragonsToothPickup.
//=============================================================================
class FlameSwordPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.FlameSword.BWsword_SH1');
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.FlameSword.BWsword_SH2');
	L.AddPrecacheMaterial(Shader'BWBP_OP_Tex.FlameSword.BWsword_SH3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.FlameSword.BWsword_SH1');
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.FlameSword.BWsword_SH2');;
	Level.AddPrecacheMaterial(Shader'BWBP_OP_Tex.FlameSword.BWsword_SH3');;
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.FlameSword.FlameSwordPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.FlameSword.FlameSwordPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.FlameSword.FlameSwordPickupLo'
     InventoryType=Class'BWBP_OP_Pro.FlameSword'
     RespawnTime=50.000000
     PickupMessage="You picked up the PSI-56 Fire Sword."
     PickupSound=Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Equip'
     StaticMesh=StaticMesh'BWBP_OP_Static.FlameSword.FlameSwordPickupHi'
     Physics=PHYS_None
     DrawScale=1.000000
     CollisionHeight=3.500000
}
