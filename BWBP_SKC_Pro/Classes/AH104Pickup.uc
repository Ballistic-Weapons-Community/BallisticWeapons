//=============================================================================
// AH104Pickup.
//=============================================================================
class AH104Pickup extends BallisticHandgunPickup
	placeable;

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AH104.AH104-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AH104.AH104-Misc');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AH104.AH104-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AH104.AH104-Misc');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.AH104.AH104_SM_Main');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.AH104.AH104_SM_Ammo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.AH104.AH104_SM_Main'
     PickupDrawScale=0.100000
     InventoryType=Class'BWBP_SKC_Pro.AH104Pistol'
     RespawnTime=10.000000
     PickupMessage="You picked up the AH104 Handcannon"
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.AH104.AH104_SM_Main'
     Physics=PHYS_None
     DrawScale=0.100000
     PrePivot=(Y=-26.000000)
     CollisionHeight=4.000000
}
