//=============================================================================
// SK410Pickup.
//[3:48:00 PM] Paul: you experience shiot at work
//[3:48:00 PM] Blade Sword: some people just spam a bit
//[3:48:10 PM] Paul: then you go after your favorutie fretime activities
//[3:48:15 PM] Paul: you check out the forum
//[3:48:18 PM] Paul: what do you find ?
//[3:48:20 PM] Paul: shit
//[3:48:22 PM] Paul: indeed !
//=============================================================================
class SK410Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_SKC_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx
#exec OBJ LOAD FILE=BWBP_SKC_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.SK410.SK410-C-CamoSnow');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.SK410.SK410-Misc');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763Bash');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763BashWood');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763Flash1');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.SK410.SK410-C-CamoSnow');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.SK410.SK410-Misc');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763Bash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763BashWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.SK410.SK410Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.SK410.SK410Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.SK410.SK410Pickup'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBPRecolorsPro.SK410Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SK-410 assault shotgun."
     PickupSound=Sound'BW_Core_WeaponSound.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.SK410.SK410Pickup'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=3.000000
}
