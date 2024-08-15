class CoachGunPickup extends BallisticHandGunPickup
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.Coach-Main');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.DBL-Misc');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.DBL-MiscBlack');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763Bash');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763BashWood');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6MuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.Coach-Main');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.Coach-Misc');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.CoachGun.DBL-MiscBlack');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Concrete');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Metal');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Shell_Wood');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763Bash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.M763BashWood');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRT6.MRT6MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Brass.EmptyShell');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.Ammo.M763ShellBox');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.CoachGun.DoubleShotgunPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.CoachGun.DoubleShotgunPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.CoachGun.DoubleShotgunPickupLo'
     InventoryType=Class'BWBP_SKC_Pro.CoachGun'
     RespawnTime=15.000000
     PickupMessage="You picked up the Redwood Coach Gun."
     PickupSound=Sound'BW_Core_WeaponSound.M290.M290Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.CoachGun.DoubleShotgunPickupHi'
     Physics=PHYS_None
     DrawScale=0.650000
     CollisionHeight=3.500000
}
