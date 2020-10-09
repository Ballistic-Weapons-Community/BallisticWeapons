//=============================================================================
// BOGPGrenade.
//
// Grenade fired by the BGOP Grenade Pistol.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPGrenade extends BallisticGrenade;

var bool bArmed;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	SetTimer(0.20, False);
}

simulated function Timer()
{
	if(StartDelay > 0)
	{
		Super.Timer();
		return;
	}
	
	if (!bHasImpacted)
		DetonateOn=DT_Impact;
		
	else Explode(Location, vect(0,0,1));
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
     DetonateOn=DT_ImpactTimed
     bNoInitialSpin=True
     bAlignToVelocity=True
     DetonateDelay=1.000000
     ImpactDamage=25
     ImpactDamageType=Class'BallisticProV55.DTBOGPGrenade'
     ImpactManager=Class'BallisticProV55.IM_M50Grenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BallisticProV55.DTBOGPGrenadeRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=256.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     Speed=3500.000000
     Damage=120.000000
     DamageRadius=512.000000
     MyDamageType=Class'BallisticProV55.DTBOGPGrenadeRadius'
     ImpactSound=SoundGroup'BallisticSounds2.NRP57.NRP57-Concrete'
     StaticMesh=StaticMesh'BallisticHardware_25.BOGP.BOGP_Grenade'
     DrawScale=0.300000
     bIgnoreTerminalVelocity=True
}
