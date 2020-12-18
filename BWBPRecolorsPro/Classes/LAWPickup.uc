//=============================================================================
// LAWPickup.
//=============================================================================
class LAWPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticRecolors4TexPro.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx
#exec OBJ LOAD FILE=BallisticRecolors4StaticProExp.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LAW.LAW-Main');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LAW.LAW-Rocket');
	L.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LAW.LAW-ScopeView');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWRocket');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaBackFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LAW.LAW-Main');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LAW.LAW-Rocket');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors4TexPro.LAW.LAW-ScopeView');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWRocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.G5.BazookaBackFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWPickup');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWPickup'
     PickupDrawScale=0.700000
     InventoryType=Class'BWBPRecolorsPro.LAWLauncher'
     RespawnTime=120.000000
     PickupMessage="You picked up the FGM-70 'Shockwave' LAW."
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.LAW.LAWPickup'
     Physics=PHYS_None
     DrawScale=0.700000
     CollisionHeight=6.000000
}
