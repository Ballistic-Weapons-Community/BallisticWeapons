class LonghornPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Longhorn.Longhorn-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Longhorn.Longhorn-Ammo');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.ClusterProj');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.GrenadeProj');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.LonghornBrass');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Longhorn.Longhorn-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.Longhorn.Longhorn-Ammo');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.ClusterProj');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.GrenadeProj');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.LonghornAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.LonghornBrass');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Longhorn.LonghornPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Longhorn.LonghornPickup'
     PickupDrawScale=0.090000
     InventoryType=Class'BWBPRecolorsPro.LonghornLauncher'
     RespawnTime=10.000000
     PickupMessage="You picked up the Longhorn repeater."
     PickupSound=Sound'BallisticSounds2.M806.M806Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Longhorn.LonghornPickup'
     Physics=PHYS_None
     DrawScale=0.110000
     CollisionHeight=4.000000
}
