//=============================================================================
// Akeron Launcher pickup.
//=============================================================================
class AkeronPickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronFront');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronBack');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronGrip');
	L.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronMag');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
	
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaBackFlash');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronFront');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronBack');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronGrip');
	Level.AddPrecacheMaterial(Texture'BWBP_OP_Tex.Akeron.AkeronMag');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Explode2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Particles.Shockwave');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion1');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion2');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion3');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.Decals.Explosion4');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.G5.BazookaBackFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Akeron.AkeronAmmo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Akeron.AkeronHi');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP_OP_Static.Akeron.AkeronLo');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP_OP_Static.Akeron.AkeronLo'
     PickupDrawScale=1.450000
     InventoryType=Class'BWBP_OP_Pro.AkeronLauncher'
     RespawnTime=20.000000
     PickupMessage="You picked up the AN-56 Akeron launcher."
     PickupSound=Sound'BW_Core_WeaponSound.G5.G5-Putaway'
     StaticMesh=StaticMesh'BWBP_OP_Static.Akeron.AkeronHi'
     Physics=PHYS_None
     DrawScale=1.450000
     CollisionHeight=6.000000
}
