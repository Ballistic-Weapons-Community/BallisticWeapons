//=============================================================================
// FM14FlakGrenade.
//
// Grenade fired by M900 Attached grenade launcher.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FM14FlakGrenade extends BallisticGrenade;

//var bool bArmed;
//var float ArmingDelay;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	SetTimer(ArmingDelay, False);
}

//hit directly, turn off the darts to avoid catastrophic brain hemorrhage
simulated function bool Impact(Actor Other, Vector HitLocation)
{
	FlakCount=0;
	super.Impact(Other, HitLocation);

	return true;
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
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);
    }
}

defaultproperties
{
    ArmingDelay=0.3
    DetonateOn=DT_Timer
    PlayerImpactType=PIT_Bounce
    bNoInitialSpin=True
    bAlignToVelocity=True
    DetonateDelay=8.000000
    ImpactDamage=105
	FlakCount=20
	FlakClass=Class'BWBP_APC_Pro.FM14Dart'
    ImpactDamageType=Class'BWBP_APC_Pro.DTFM14Grenade'
    ImpactManager=Class'BallisticProV55.IM_M50Grenade'
    ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
    TrailClass=Class'BallisticProV55.M50GrenadeTrail'
    TrailOffset=(X=-8.000000)
    MyRadiusDamageType=Class'BWBP_APC_Pro.DTFM14GrenadeRadius'
    SplashManager=Class'BallisticProV55.IM_ProjWater'
    ShakeRadius=512.000000
    MotionBlurRadius=384.000000
    MotionBlurFactor=3.000000
    MotionBlurTime=4.000000
    Speed=3500.000000
    Damage=15.000000
    DamageRadius=32.000000
    WallPenetrationForce=128
    MyDamageType=Class'BallisticProV55.DTM50GrenadeRadius'
    ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
    StaticMesh=StaticMesh'BW_Core_WeaponStatic.M900.M900Grenade'
    bIgnoreTerminalVelocity=True
	ModeIndex=1
}
