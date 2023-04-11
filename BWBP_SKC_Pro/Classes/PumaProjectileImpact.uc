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


simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}
	else if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
	{
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.2;
		DampenFactorParallel *= 0.2;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	Speed = VSize(Velocity);

	if (Speed < 20)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc );
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    	}
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.PumaRepeater'
     DetonateOn=DT_ImpactTimed
     PlayerImpactType=PIT_Detonate
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
