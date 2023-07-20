//=============================================================================
// RGPXFlakRocket.
//
// Flak projectile spawned by RPG-350 cluster rockets
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RGPXFlakRocket extends BallisticGrenade;

var   float NewSpeed;			// Speed sent to clients
var   bool	bFlakInitialized;

replication
{
	reliable if (Role==ROLE_Authority)
		NewSpeed;
}

simulated event Timer()
{
	if (Role < ROLE_Authority && NewSpeed == default.NewSpeed)
	{
		SetTimer(0.1, false);
		return;
	}
	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		return;
	}
}

function InitFlak(float FSpeed)
{
	Speed = FSpeed;
	NewSpeed = Speed;
}

simulated function InitProjectile ()
{
	bFlakInitialized = true;
	Super.InitProjectile();
}
simulated event PostNetReceive()
{
	Super.PostNetReceive();

	if (NewSpeed != default.NewSpeed)
		Speed = NewSpeed;
	if (!bFlakInitialized && NewSpeed != default.NewSpeed)
	{
		if (StartDelay == 0)
			InitProjectile();
	}
}

defaultproperties
{    
    WeaponClass=Class'BWBP_JCF_Pro.RGPXBazooka'
	bApplyParams=False
	StartDelay=0.100000
	NewSpeed=-0.100000
	ImpactManager=Class'BWBP_JCF_Pro.IM_RGPX'
	bRandomStartRotation=True
	DetonateOn=DT_Impact
	Physics=PHYS_Falling
	TrailClass=Class'BWBP_SKC_Pro.LonghornGrenadeTrailSmall'
	MyRadiusDamageType=Class'BWBP_JCF_Pro.DTRGPXBazookaRadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=378.000000
	MotionBlurRadius=512.000000
	ShakeRotMag=(X=512.000000,Y=400.000000)
	ShakeRotRate=(X=3000.000000,Z=3000.000000)
	ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
	Speed=5.000000
	AccelSpeed=200.000000
	Damage=50.000000
	DamageRadius=256.000000
	WallPenetrationForce=384
	MomentumTransfer=15000.000000
	MyDamageType=Class'BWBP_JCF_Pro.DTRGPXBazooka'
	StaticMesh=StaticMesh'BWBP_JCF_Static.RGP-X350.RGP-X350_ProjMini'
	bDynamicLight=True
	bNetTemporary=False
	bUpdateSimulatedPosition=True
	DrawScale=0.180000
	SoundVolume=192
	SoundRadius=128.000000
	CollisionRadius=4.000000
	CollisionHeight=4.000000
	bUseCollisionStaticMesh=True
	bFixedRotationDir=True
}
