class TrenchGunPickup extends BallisticHandGunPickup
	placeable;

#exec OBJ LOAD FILE=BWBP_OP_Tex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_OP_Static.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBP_SKC_Tex.TechWrench.TechWrenchShiny');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.TechWrench.CryoShell');
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.TechWrench.ShockShell');
	L.AddPrecacheMaterial(Shader'BWBP_SKC_Tex.TechWrench.WrenchShiny');
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
	Level.AddPrecacheMaterial(Shader'BWBP_SKC_Tex.TechWrench.TechWrenchShiny');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.TechWrench.CryoShell');
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.TechWrench.ShockShell');
	Level.AddPrecacheMaterial(Shader'BWBP_SKC_Tex.TechWrench.WrenchShiny');
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
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.TechGun.TechGunPickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.TechGun.TechGunPickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.TechGun.TechGunPickupLo'
     InventoryType=Class'BWBP_OP_Pro.TrenchGun'
     RespawnTime=15.000000
     PickupMessage="You picked up the BR-112 sapper's trenchgun."
     PickupSound=Sound'BW_Core_WeaponSound.M290.M290Putaway'
     StaticMesh=StaticMesh'BWBP_SKC_Static.TechGun.TechGunPickupHi'
     Physics=PHYS_None
     DrawScale=1.50000
     CollisionHeight=3.500000
}
