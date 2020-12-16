//=============================================================================
// ChaffPickup.
//=============================================================================
class ChaffPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
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
	L.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M4A1.M4-Ord');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');

	L.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MOAC.MOACProj');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_SKC_Tex.M4A1.M4-Ord');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MOAC.MOACPickup');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_SKC_Static.MOAC.MOACProj');
}

defaultproperties
{
     bOnSide=False
     LowPolyStaticMesh=StaticMesh'BWBP_SKC_Static.MOAC.MOACPickup'
     PickupDrawScale=0.180000
     bWeaponStay=False
     InventoryType=Class'BWBPRecolorsPro.ChaffGrenadeWeapon'
     RespawnTime=20.000000
     PickupMessage="You picked up the MOA-C chaff grenade."
     PickupSound=Sound'BW_Core_WeaponSound.Ammo.GrenadePickup'
     StaticMesh=StaticMesh'BWBP_SKC_Static.MOAC.MOACPickup'
     bOrientOnSlope=True
     Physics=PHYS_None
     DrawScale=2.000000
     CollisionHeight=5.600000
}
