//=============================================================================
// MRLPickup.
//=============================================================================
class MRLPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRL.MRL_Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRL.MRL_AmmoBox');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRL.MRL_Rocket');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');

	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRL.MRL_Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRL.MRL_AmmoBox');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.MRL.MRL_Rocket');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRL.JL21Pickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRL.JL21Pickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.MRL.JL21-Ammo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.JL21Pickup-LD'
     PickupDrawScale=0.280000
     InventoryType=Class'BallisticProV55.MRocketLauncher'
     RespawnTime=120.000000
     PickupMessage="You got the JL21-MRL PeaceMaker."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.JL21Pickup-HD'
     Physics=PHYS_None
     DrawScale=0.325000
     PrePivot=(Z=-18.000000)
     CollisionHeight=6.000000
}
