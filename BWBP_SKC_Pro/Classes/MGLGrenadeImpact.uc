//=============================================================================
// MGLGrenadeImpact.
//
// Grenade fired by MGL-870 grenade launcher.
// If it hits a wall or player too early it will disarm
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MGLGrenadeImpact extends BallisticGrenade;

var bool bArmed;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	SetTimer(0.05, False);
}

simulated function InitProjectile ()
{
    if (RandomSpin != 0 && !bNoInitialSpin)
        RandSpin(RandomSpin);
    SetTimer(DetonateDelay, false);
    Super.InitProjectile();
}

simulated function Timer()
{
	if (StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	if (!bHasImpacted)
		DetonateOn=DT_Impact;

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
    WeaponClass=Class'BWBP_SKC_Pro.MGLauncher'
     DetonateOn=DT_None
     PlayerImpactType=PIT_Bounce
     DampenFactor=0.050000
     DampenFactorParallel=0.300000
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=0.500000
     ImpactDamage=100
     ImpactDamageType=Class'BWBP_SKC_Pro.DTMGLGrenade'
     ImpactManager=Class'BWBP_SKC_Pro.IM_MGLGrenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BWBP_SKC_Pro.MGLNadeTrail'
     TrailWhenStill=False
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
}
