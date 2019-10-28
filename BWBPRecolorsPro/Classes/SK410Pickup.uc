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

#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.SK410.SK410-C-CamoSnow');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.SK410.SK410-Misc');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763Bash');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763BashWood');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763Flash1');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.SK410.SK410-C-CamoSnow');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.SK410.SK410-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763Bash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763BashWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.M763.M763Flash1');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.SK410.SK410Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.SK410.SK410Pickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.SK410.SK410Pickup'
     PickupDrawScale=0.400000
     InventoryType=Class'BWBPRecolorsPro.SK410Shotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the SK-410 assault shotgun."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.SK410.SK410Pickup'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=3.000000
}
