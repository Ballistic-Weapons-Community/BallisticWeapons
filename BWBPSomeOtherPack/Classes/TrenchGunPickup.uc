class TrenchGunPickup extends BallisticHandGunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticProExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-MiscBlack');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763Bash');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763BashWood');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.MRT6.MRT6MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-MiscBlack');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763Bash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.M763BashWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.MRT6.MRT6MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.Ammo.M763ShellBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.Redwood.DoubleShotgunPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Redwood.DoubleShotgunPickup'
     InventoryType=Class'BWBPSomeOtherPack.TrenchGun'
     RespawnTime=15.000000
     PickupMessage="You picked up the BR-112 Sappers Trechgun."
     PickupSound=Sound'BallisticSounds2.M290.M290Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Redwood.DoubleShotgunPickup'
     Physics=PHYS_None
     DrawScale=0.650000
     CollisionHeight=3.500000
}
