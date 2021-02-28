class LonghornPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Longhorn.Longhorn-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Longhorn.Longhorn-Ammo');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.ClusterProj');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.GrenadeProj');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.LonghornBrass');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Longhorn.Longhorn-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.Longhorn.Longhorn-Ammo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.ClusterProj');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.GrenadeProj');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.LonghornAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.LonghornBrass');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.Longhorn.LonghornPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.Longhorn.LonghornPickup'
     PickupDrawScale=0.090000
     InventoryType=Class'BWBPRecolorsPro.LonghornLauncher'
     RespawnTime=10.000000
     PickupMessage="You picked up the Longhorn repeater."
     PickupSound=Sound'BW_Core_WeaponSound.M806.M806Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Longhorn.LonghornPickup'
     Physics=PHYS_None
     DrawScale=0.110000
     CollisionHeight=4.000000
}
