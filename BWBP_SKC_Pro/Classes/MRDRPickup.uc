//=============================================================================
// MRDRPickup.
//=============================================================================
class MRDRPickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MRDR.MRDR-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MRDR.MRDR-Spec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MRDR.MRDRMuzzleFlash');
}


simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MRDR.MRDR-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MRDR.MRDR-Spec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.MRDR.MRDRMuzzleFlash');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MRDR.MRDR88AmmoPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MRDR.MRDR88Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MRDR.MRDR88Pickup'
     PickupDrawScale=0.250000
     InventoryType=Class'BWBP_SKC_Pro.MRDRMachinePistol'
     RespawnTime=20.000000
     PickupMessage="You picked up the MR-DR88 machine pistol."
     PickupSound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MRDR.MRDR88Pickup'
     Physics=PHYS_None
     DrawScale=0.500000
     PrePivot=(Y=-16.000000)
     CollisionHeight=4.000000
}
