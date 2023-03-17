//=============================================================================
// PUMAProjectile.
//
// Energy explosive. Airbursts on enemies, otherwise bounces and explodes.
// Firing while shield up is bad idea.
//
// Wall fuse is .05 for all projectiles. Arming fuse is .1.
// Hitting a wall or player will immideately arm the grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PUMAProjectile extends BallisticGrenade;
var bool bPrimed;

simulated function PostBeginPlay()
{
	SetTimer(0.10, false);
	super.PostBeginPlay();
}

simulated event Timer()
{
	if (!bPrimed)
	{
		bPrimed=true;
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

	local Actor Target;

	if (bAlignToVelocity && ( RandomSpin == 0 || (bNoInitialSpin && !bHasImpacted) ))
		SetRotation(Rotator(Velocity));

	foreach VisibleCollidingActors( class 'Actor', Target, DamageRadius-70, Location )
	{

		if (Target.bCanBeDamaged && Target != self && bPrimed)
		{
//			bPrimed = false; //Only explode once
//			Explode(Location, vect(0,0,1));
			SetTimer(0.01, false);
		}

	}

}


// MODIFIED: Damage will never drop off below 40% of base. DRange = 50 to 20.
// 
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMin(0.6,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
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
		bPrimed=true;
		SetTimer(DetonateDelay, false);
	}
	if (Pawn(Wall) != None)
	{
		DampenFactor *= 0.5;
		DampenFactorParallel *= 0.5;
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
     ImpactDamage=90
     ImpactDamageType=Class'BWBP_SKC_Pro.DT_PUMAGrenade'
     ImpactManager=Class'BWBP_SKC_Pro.IM_PumaDet'
     TrailClass=Class'BWBP_SKC_Pro.PumaProjectileTrail'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_PUMARadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=300.000000
     MotionBlurRadius=200.000000
     MotionBlurFactor=2.000000
     MotionBlurTime=1.000000
     ShakeRotTime=1.000000
     Speed=6500.000000
     Damage=75.000000
     DamageRadius=300.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_PUMAGrenade'
     ImpactSound=Sound'BW_Core_WeaponSound.MRS38.RSS-ElectroHit1'
     LightHue=180
     LightSaturation=100
     LightBrightness=160.000000
     LightRadius=8.000000
     StaticMesh=StaticMesh'BWBP_SKC_Static.Bulldog.Frag12Proj'
     LifeSpan=16.000000
     DrawScale=1.5000000
}
