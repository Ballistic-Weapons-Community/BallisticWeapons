//=============================================================================
// E23Pickup.
//=============================================================================
class E23Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BWBP4-Tex.utx
#exec OBJ LOAD FILE=BWBP4-hardware.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR_Main');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR_Glass');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRMain-SpecMask');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRGlass-SpecMask');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRLaserBeam');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRBolt');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR-MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR-MuzzleEffect');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.Ripple-VPR');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRBolt-Flare');
	L.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR-Impact');

	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.VPR.VPRMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.VPR.VPRProjectile');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR_Main');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR_Glass');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRMain-SpecMask');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRGlass-SpecMask');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRLaserBeam');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRBolt');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR-MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR-MuzzleEffect');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.Ripple-VPR');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPRBolt-Flare');
	Level.AddPrecacheMaterial(Texture'BWBP4-Tex.VPR.VPR-Impact');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.VPR.VPR-Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.VPR.VPRMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.VPR.VPRPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.VPR.VPRPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BWBP4-Hardware.VPR.VPRProjectile');
}

event Landed(Vector HitNormal)
{
	local Rotator R, Dir;
	local Vector X, Y, Z;

	if (bOnSide)
	{
		Dir = Rotator(HitNormal);
		Dir.Pitch -= 16384;
		R.Yaw = Rotation.Yaw;
		GetAxes (R,X,Y,Z);
		X = X >> Dir;
		Y = Y >> Dir;
		Z = Z >> Dir;
		Dir = OrthoRotation (X,Y,Z);
		Dir.Roll -= 16384;
		SetRotation(Dir);

		LandedRot = Rotation;
	}
    GotoState('Pickup','Begin');
}

defaultproperties
{
     LowPolyStaticMesh=StaticMesh'BWBP4-Hardware.VPR.VPRPickup-LD'
     PickupDrawScale=0.200000
     InventoryType=Class'BallisticProV55.E23PlasmaRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the E-23 'ViPeR'."
     PickupSound=Sound'BallisticSounds2.A73.A73Putaway'
     StaticMesh=StaticMesh'BWBP4-Hardware.VPR.VPRPickup-HD'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.500000
}
