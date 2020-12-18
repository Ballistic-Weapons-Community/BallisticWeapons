//=============================================================================
// ChaffPickup.
//=============================================================================
class ChaffPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BallisticWeapons2.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BallisticRecolors4StaticPro.usx

//===========================================================================
// StaticPrecache
//
// Explicitly called by some gametypes upon the pickup class to preload it.
// A gametype needing to do this won't spawn any pickups. Don't preload them or their assets here.
//===========================================================================
static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.M4A1.M4-Ord');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');

	L.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.MOAC.MOACProj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BallisticRecolors3TexPro.M4A1.M4-Ord');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.MOAC.MOACPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BallisticRecolors4StaticPro.MOAC.MOACProj');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BallisticRecolors4StaticPro.MOAC.MOACPickup'
     PickupDrawScale=0.180000
     bWeaponStay=False
     InventoryType=Class'BWBPRecolorsPro.ChaffGrenadeWeapon'
     RespawnTime=20.000000
     PickupMessage="You picked up the MOA-C chaff grenade."
     PickupSound=Sound'BallisticSounds2.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BallisticRecolors4StaticPro.MOAC.MOACPickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=2.000000
     CollisionHeight=5.600000
}
