//=============================================================================
// ThumperMineRemote.
//
// Mine fired by the thumper.
// Remote detonation. Gun holds an array of 6 of these.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ThumperMineRemote extends BallisticGrenade;

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
    WeaponClass=Class'BWBP_SKC_Pro.MGLauncher'
     ModeIndex=1
     ArmedDetonateOn=DT_None
     ArmedPlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
     bAlignToVelocity=True
     DampenFactor=0.050000
     DampenFactorParallel=0.300000
     DetonateDelay=0.350000
     ImpactDamage=60
     ImpactDamageType=Class'BWBP_SKC_Pro.DTMGLGrenade'
     ImpactManager=Class'BWBP_SKC_Pro.IM_MGLGrenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BWBP_SKC_Pro.MGLNadeTrail'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DTMGLGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=400.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     WallPenetrationForce=64
     Speed=4500.000000
     Damage=140.000000
     DamageRadius=768.000000
     MyDamageType=Class'BWBP_SKC_Pro.DTMGLGrenadeRadius'
     ImpactSound=Sound'BWBP_SKC_Sounds.Misc.FLAK-GrenadeBounce'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade'
     bNetTemporary=False
     bUpdateSimulatedPosition=True
}
