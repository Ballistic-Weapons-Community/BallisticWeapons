//=============================================================================
// MGL870Grenade.
//
// Grenade fired by MGL-870 grenade launcher.
// Remote detonation. Has a timer so you can't airburst it left and right
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGLGrenadeRemote extends BallisticGrenade;

var	bool	bReady;

simulated event Timer() //Timer will handle remote det lock
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
	bReady=true;
}

simulated function InitProjectile ()
{
	InitEffects();
	Velocity = Speed * Vector(VelocityDir);
	if (RandomSpin != 0 && !bNoInitialSpin)
		RandSpin(RandomSpin);
	SetTimer(DetonateDelay, false);
}

function RemoteDetonate()
{
	if (bReady)
		Explode(Location, vect(0,0,1));
}

defaultproperties
{
     DetonateOn=DT_None
     PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
     DampenFactor=0.050000
     DampenFactorParallel=0.300000
     DetonateDelay=0.350000
     ImpactDamage=25
     ImpactDamageType=Class'BWBPRecolorsPro.DTMGLGrenade'
     ImpactManager=Class'BWBPRecolorsPro.IM_MGLGrenade'
     TrailClass=Class'BWBPRecolorsPro.MGLNadeTrail'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTMGLGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=400.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     bCoverPenetrator=True
     Speed=4500.000000
     Damage=145.000000
     DamageRadius=300.000000
     MyDamageType=Class'BWBPRecolorsPro.DTMGLGrenadeRadius'
     ImpactSound=Sound'PackageSounds4Pro.Misc.FLAK-GrenadeBounce'
     StaticMesh=StaticMesh'BallisticHardware2.M900.M900Grenade'
     bNetTemporary=False
     bUpdateSimulatedPosition=True
}
