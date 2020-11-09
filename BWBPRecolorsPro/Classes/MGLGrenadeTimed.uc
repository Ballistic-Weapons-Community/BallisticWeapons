//=============================================================================
// MGL870Grenade.
//
// Grenade fired by MGL-870 grenade launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGLGrenadeTimed extends BallisticGrenade;

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
	
	Speed = VSize(Velocity/2);

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
			PlaySound(ImpactSound, SLOT_Misc, 1.5);
		if (ReflectImpactManager != None)
		{
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);			
		}
    }
}

defaultproperties
{
     PlayerImpactType=PIT_Detonate
     bNoInitialSpin=True
	 bAlignToVelocity=True
	 DampenFactor=0.050000
     DampenFactorParallel=0.300000
     DetonateDelay=2.000000
     ImpactDamage=60
     ImpactDamageType=Class'BWBPRecolorsPro.DTMGLGrenade'
     ImpactManager=Class'BWBPRecolorsPro.IM_MGLGrenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BWBPRecolorsPro.MGLNadeTrail'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DTMGLGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=400.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     WallPenetrationForce=256
     Speed=4500.000000
     Damage=140.000000
     DamageRadius=768.000000
     MyDamageType=Class'BWBPRecolorsPro.DTMGLGrenadeRadius'
     ImpactSound=Sound'PackageSounds4Pro.Misc.FLAK-GrenadeBounce'
     StaticMesh=StaticMesh'BallisticHardware2.M900.M900Grenade'
}
