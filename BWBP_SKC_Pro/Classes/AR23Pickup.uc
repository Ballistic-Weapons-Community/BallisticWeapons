//=============================================================================
// AR23Pickup.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class AR23Pickup extends BallisticWeaponPickup
	placeable;

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-MainSpec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-MiscSpec');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-Holosight');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.Muzzle_2D_View');
}
simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-MainSpec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-MiscSpec');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.AR23-Holosight');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.AR23.Muzzle_2D_View');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.AR23.AR23_SM_Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.AR23.AR23_SM_Main');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.AR23.AR23_SM_Main'
     PickupDrawScale=0.130000
     InventoryType=Class'BWBP_SKC_Pro.AR23HeavyRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the AR23 'Punisher' Heavy Rifle"
     PickupSound=Sound'BW_Core_WeaponSound.M50.M50Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.AR23.AR23_SM_Main'
     Physics=PHYS_None
     DrawScale=0.130000
     CollisionHeight=4.000000
}
