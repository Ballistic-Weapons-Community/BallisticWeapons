//=============================================================================
// MACPickup.
//=============================================================================
class MACPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BallisticEffects.utx
#exec OBJ LOAD FILE=BWBP4-Hardware.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Artillery.Artillery_Main');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.Artillery.Artillery_Glass');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');

	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Artillery.Blast-FX');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Artillery.Artillery_Main');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.Artillery.Artillery_Glass');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BallisticEffects.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Artillery.ArtilleryPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Artillery.ArtilleryPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Artillery.Blast-FX');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.Artillery.Artillery-Ammo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.Artillery.ArtilleryPickup-LD'
     PickupDrawScale=0.250000
     InventoryType=Class'BallisticProV55.MACWeapon'
     RespawnTime=120.000000
     PickupMessage="You picked up the Heavy Anti-Materiel Rifle."
     PickupSound=Sound'BallisticSounds2.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.Artillery.ArtilleryPickup-HD'
     Physics=PHYS_None
     DrawScale=0.325000
     PrePivot=(Z=-14.000000)
     CollisionHeight=6.000000
}
