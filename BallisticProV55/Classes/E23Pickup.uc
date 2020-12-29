//=============================================================================
// E23Pickup.
//=============================================================================
class E23Pickup extends BallisticWeaponPickup
	placeable;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BW_Core_WeaponStatic.usx

static function StaticPrecache(LevelInfo L)
{
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR_Main');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR_Glass');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRMain-SpecMask');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRGlass-SpecMask');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRLaserBeam');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRBolt');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR-MuzzleFlash');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR-MuzzleEffect');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.Ripple-VPR');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRBolt-Flare');
	L.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR-Impact');

	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.VPR.VPRMuzzleFlash');
	L.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.VPR.VPRProjectile');
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR_Main');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR_Glass');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRMain-SpecMask');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRGlass-SpecMask');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRLaserBeam');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRBolt');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR-MuzzleFlash');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR-MuzzleEffect');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.Ripple-VPR');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPRBolt-Flare');
	Level.AddPrecacheMaterial(Texture'BW_Core_WeaponTex.VPR.VPR-Impact');
}
simulated function UpdatePrecacheStaticMeshes()
{
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.VPR.VPR-Ammo');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.VPR.VPRMuzzleFlash');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.VPR.VPRPickup-HD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.VPR.VPRPickup-LD');
	Level.AddPrecacheStaticMesh(StaticMesh'BW_Core_WeaponStatic.VPR.VPRProjectile');
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
     LowPolyStaticMesh=StaticMesh'BW_Core_WeaponStatic.VPR.VPRPickup-LD'
     PickupDrawScale=0.200000
     InventoryType=Class'BallisticProV55.E23PlasmaRifle'
     RespawnTime=20.000000
     PickupMessage="You picked up the E-23 'ViPeR'."
     PickupSound=Sound'BW_Core_WeaponSound.A73.A73Putaway'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.VPR.VPRPickup-HD'
     Physics=PHYS_None
     DrawScale=0.400000
     CollisionHeight=4.500000
}
