//=============================================================================
// SMATGrenade.
//
// Grenade fired by SMAT Launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_Detonator extends BallisticGrenade;


var   Supercharger_ChargeControl	ChargeControl;
var   Vector			EndPoint, StartPoint;
var   array<actor>		AlreadyHit;

simulated event PreBeginPlay()
{
	if (Owner != None && Pawn(Owner) != None)
		Instigator = Pawn(Owner);
	super.PreBeginPlay();
}
/*
simulated function Timer()
{
	if (StartDelay > 0)
	{
		SetCollision(true, false, false);
		StartDelay = 0;
		SetPhysics(default.Physics);
		bDynamicLight=default.bDynamicLight;
		bHidden=default.bHidden;
		InitProjectile();
	}
	else
		super.Timer();
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
//    local Vector X;
    local int i;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;
	if (Other.Base == Instigator)
		return;
	for(i=0;i<AlreadyHit.length;i++)
		if (AlreadyHit[i] == Other)
			return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
		DoDamage(Other, HitLocation);
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		AlreadyHit[AlreadyHit.length] = Other;
		HitActor = Other;
	}
	else
		Destroy();

	if (Pawn(Other) != None)
		ChargeControl.FireSinge(Pawn(Other), Instigator);
}
*/
defaultproperties
{
     bNoInitialSpin=True
	 bApplyParams=False
     bAlignToVelocity=True
     DetonateDelay=0.100001
     ImpactDamage=120
     ImpactManager=Class'BWBP_SKC_Pro.IM_XMExplosion'
	 bRandomStartRotation=False
     TrailClass=Class'BallisticProV55.M50GrenadeTrail'
     TrailOffset=(X=-8.000000)
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_Supercharge'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1024.000000
     MotionBlurRadius=1024.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=0.010000
     MaxSpeed=10000.000000
     Damage=400.000000
     DamageRadius=300.000000
     MomentumTransfer=180000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_Supercharge'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=200.000000
     LightRadius=15.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.G5.G5Rocket'
     bDynamicLight=True
     AmbientSound=Sound'BW_Core_WeaponSound.G5.G5-RocketFly'
     DrawScale=0.500000
     SoundVolume=192
     SoundRadius=128.000000
     RotationRate=(Roll=32768)
}
