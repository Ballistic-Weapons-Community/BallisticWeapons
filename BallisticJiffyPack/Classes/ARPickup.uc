//=============================================================================
// SK410Pickup.
//=============================================================================
class ARPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors3TexPro.utx
#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BWBPJiffyPackTex.utx

#exec OBJ LOAD FILE=BallisticHardware2.usx
#exec OBJ LOAD FILE=BWBPJiffyPackStatic.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Shader'BWBPJiffyPackTex.TacBuster.TacBusterShiny');
	L.AddPrecacheMaterial(Shader'BWBPJiffyPackTex.TacBuster.BusterGrenadeShiny');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-Misc');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.Reflex');
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
	Level.AddPrecacheMaterial(Shader'BWBPJiffyPackTex.TacBuster.TacBusterShiny');
	Level.AddPrecacheMaterial(Shader'BWBPJiffyPackTex.TacBuster.BusterGrenadeShiny');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.CoachGun.DBL-Misc');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.CYLO.Reflex');
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
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPJiffyPackStatic.TacticalBuster.AA12Pickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPJiffyPackStatic.TacticalBuster.AA12AmmoPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBPJiffyPackStatic.TacticalBuster.AA12GrenadePickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBPJiffyPackStatic.TacticalBuster.AA12Pickup'
     PickupDrawScale=1.300000
     InventoryType=Class'BallisticJiffyPack.ARShotgun'
     RespawnTime=20.000000
     PickupMessage="You picked up the RCS-715 Tactical Buster."
     PickupSound=Sound'BallisticSounds2.M763.M763Putaway'
     StaticMesh=StaticMesh'BWBPJiffyPackStatic.TacticalBuster.AA12Pickup'
     Physics=PHYS_None
     DrawScale=2.000000
     CollisionHeight=3.000000
}
