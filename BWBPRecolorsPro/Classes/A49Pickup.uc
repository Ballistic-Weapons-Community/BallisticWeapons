//=============================================================================
// A49Pickup.
//=============================================================================
class A49Pickup extends BallisticHandgunPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6PlasmaMask');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6Skin');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6PlasmaMask');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6SpecMask');
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.Ripple-A49');
	L.AddPrecacheMaterial(Texture'BallisticWeapons2.A42.A42_Exp');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A42Scorch');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile');
	L.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile2');
	
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42MuzzleFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6PlasmaMask');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6Skin');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6PlasmaMask');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.A6SpecMask');
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.A6.Ripple-A49');
	Level.AddPrecacheMaterial(Texture'BallisticWeapons2.A42.A42_Exp');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.A42Scorch');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A73MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.GunFire.A42Projectile2');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42MuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42PickupHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticHardware2.A42.A42PickupLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.A49.A49Pickup'
     PickupDrawScale=0.187000
     InventoryType=Class'BWBPRecolorsPro.A49SkrithBlaster'
     RespawnTime=20.000000
     PickupMessage="You picked up the A49 Skrith blaster."
     PickupSound=Sound'BallisticSounds2.A42.A42-Putaway'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.A49.A49Pickup'
     Physics=PHYS_None
     DrawScale=0.300000
     CollisionHeight=4.500000
}
