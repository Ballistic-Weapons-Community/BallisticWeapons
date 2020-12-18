//=============================================================================
// MRLPickup.
//=============================================================================
class MRLPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.MRL.MRL_Main');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.MRL.MRL_AmmoBox');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.MRL.MRL_Rocket');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');

	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.MRL.MRLRocket');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.MRL.MRL_Main');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.MRL.MRL_AmmoBox');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.MRL.MRL_Rocket');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.MRL.JL21Pickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.MRL.JL21Pickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.MRL.MRLRocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.MRL.JL21-Ammo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.MRL.JL21Pickup-LD'
     PickupDrawScale=0.280000
     InventoryType=Class'BallisticProV55.MRocketLauncher'
     RespawnTime=120.000000
     PickupMessage="You got the JL21-MRL PeaceMaker."
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.MRL.JL21Pickup-HD'
     Physics=PHYS_None
     DrawScale=0.325000
     PrePivot=(Z=-18.000000)
     CollisionHeight=6.000000
}
