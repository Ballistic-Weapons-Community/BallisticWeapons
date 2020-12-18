//=============================================================================
// XM84Pickup.
//=============================================================================
class XM84Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticHardware2.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// Gametypes needing to do this don't use pickups. Don't preload them here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.XM84.XM84-MainDark');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.XM84.XM84Projectile');
	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.XM84.XM84Pickup');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.XM84.XM84-MainDark');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.XM84.XM84Clip');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.XM84.XM84Projectile');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.XM84.XM84Pickup');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.XM84.XM84Pickup'
     PickupDrawScale=1.000000
     bWeaponStay=False
     InventoryType=Class'BWBPRecolorsPro.XM84Flashbang'
     RespawnTime=20.000000
     PickupMessage="You picked up the XM84 heavy tech grenade."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.XM84.XM84Pickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=2.000000
     CollisionHeight=5.600000
}
