//=============================================================================
// PUMAProjectile.
//
// Energy explosive. Bounces and explodes. Won't airburst, but is stronger/faster
// Firing while shield up is bad idea.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUMAProjectileImpact extends BallisticGrenade;

simulated event Timer()
{
	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		return;
	}
	if (HitActor != None)
	{
		if ( Instigator == None || Instigator.Controller == None )
			HitActor.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (HitActor, Damage, Instigator, Location, MomentumTransfer * (HitActor.Location - Location), MyDamageType);
	}
	Explode(Location, vect(0,0,1));
}

// Make the thing look like its pointing in the direction its going
simulated event Tick( float DT )
{
	if (bAlignToVelocity && ( RandomSpin == 0 || (bNoInitialSpin && !bHasImpacted) ))
		SetRotation(Rotator(Velocity));
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.PumaRepeater'
	ArmedDetonateOn=DT_ImpactTimed
	ArmedPlayerImpactType=PIT_Detonate
	bNoInitialSpin=True
	bAlignToVelocity=True
	DetonateDelay=0.050000
	ImpactDamage=70
	ImpactDamageType=Class'BWBP_SKC_Pro.DT_PUMAGrenade'
	ImpactManager=Class'BWBP_SKC_Pro.IM_PumaDet'
	TrailClass=Class'BWBP_SKC_Pro.PumaProjTrail'
	MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_PUMARadius'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=350.000000
	MotionBlurRadius=250.000000
	Speed=6500.000000
	Damage=60.000000
	DamageRadius=300.000000
	MomentumTransfer=10000.000000
	MyDamageType=Class'BWBP_SKC_Pro.DT_PUMAGrenade'
	LightHue=180
	LightSaturation=100
	LightBrightness=160.000000
	LightRadius=8.000000
	StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
	LifeSpan=16.000000
	DrawScale=2.000000
}
