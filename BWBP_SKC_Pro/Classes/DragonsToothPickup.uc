//=============================================================================
// DragonsToothPickup.
//=============================================================================
class DragonsToothPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx
//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DragonTooth-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DragonTooth-Red');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DragonToothCore-Red');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DTS-Glow');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DTS-AlphaMask');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DTSMask');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DragonTooth-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DragonTooth-Red');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DragonToothCore-Red');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DTS-Glow');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DTS-AlphaMask');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.DragonToothSword.DTSMask');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCut');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.KnifeCutWood');
}

simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.DTS.DragonsToothPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.DTS.DragonsToothPickup'
     PickupDrawScale=1.000000
     InventoryType=Class'BWBP_SKC_Pro.DragonsToothSword'
     RespawnTime=50.000000
     PickupMessage="You picked up the XM300 Dragon nanoblade."
     PickupSound=Sound'BWBP_SKC_Sounds.NEX.NEX-Pullout'
     StaticMesh=StaticMesh'BWBP_SKC_Static.DTS.DragonsToothPickup'
     Physics=PHYS_None
     DrawScale=0.600000
     CollisionHeight=4.000000
}
