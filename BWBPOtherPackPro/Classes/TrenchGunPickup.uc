class TrenchGunPickup extends BallisticHandGunPickup
	placeable;

#exec OBJ LOAD FILE=BWBPSomeOtherPackTex.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBPSomeOtherPackStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.TechWrench.TechWrenchShiny');
	L.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.TechWrench.CryoShell');
	L.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.TechWrench.ShockShell');
	L.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.TechWrench.WrenchShiny');
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
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.TechWrench.TechWrenchShiny');
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.TechWrench.CryoShell');
	Level.AddPrecacheMaterial(Texture'BWBPSomeOtherPackTex.TechWrench.ShockShell');
	Level.AddPrecacheMaterial(Shader'BWBPSomeOtherPackTex.TechWrench.WrenchShiny');
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
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPSomeOtherPackStatic.TechGun.TechGunPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPSomeOtherPackStatic.TechGun.TechGunPickup'
     InventoryType=Class'BWBPOtherPackPro.TrenchGun'
     RespawnTime=15.000000
     PickupMessage="You picked up the BR-112 sapper's trenchgun."
     PickupSound=Sound'BallisticSounds2.M290.M290Putaway'
     StaticMesh=StaticMesh'BWBPSomeOtherPackStatic.TechGun.TechGunPickup'
     Physics=PHYS_None
     DrawScale=1.50000
     CollisionHeight=3.500000
}
