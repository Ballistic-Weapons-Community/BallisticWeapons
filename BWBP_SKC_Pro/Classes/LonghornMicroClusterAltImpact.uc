//=============================================================================
// LonghornMicroClusterAltImpact.
//
// Small cluster bomb used by alt fire. Moves very fast but otherwise behaves
// very much like LonghornMicroClusterFlak.
//
// Deals more damage and explodes on impact.
//
// by Casey "Xavious" Johnson.
// Copyright(c) 2012 Casey Johnson. All Rights Reserved.
//=============================================================================
class LonghornMicroClusterAltImpact extends BallisticGrenade;

var float                ZBonus;
var   int    ImpactCount; // Will automatically explode after this many impacts.

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = Normal(Velocity) * AccelSpeed;
	
	if (Level.NetMode == NM_DedicatedServer)
		return;
		
	InitEffects();
	
	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (!bHasImpacted) // Detonated from direct hit - does extra damage
	{
		FlakClass=Class'BWBP_SKC_Pro.LonghornMicroClusterImpact';
		ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornCluster';
	}

	super.Explode(HitLocation, HitNormal);
}

simulated function InitProjectile ()
{
    local float r;
    
    r=((FRand()-0.50)*0.50)+1; // Lets make it a bit more random.
    DetonateDelay *= r;
    Speed*=r;
    
	Velocity = Speed * Vector(VelocityDir);
	if (RandomSpin != 0 && !bNoInitialSpin)
		RandSpin(RandomSpin);
	if (DetonateOn == DT_Timer)
		SetTimer(DetonateDelay, false);
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight; // Set up some effects, team colored
	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if(LonghornGrenadeTrail(Trail) != None)
		{
			if(Instigator != None)
			{
				LonghornGrenadeTrail(Trail).SetupColor(Instigator.GetTeamNum());
			}
		}
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir, NewMomentum;

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
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
            NewMomentum = damageScale * Momentum * dir;
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				NewMomentum,
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.LonghornLauncher'
     bAlignToVelocity=True
     bDynamicLight=True
     bNoInitialSpin=False
     Damage=25.000000
     DamageRadius=250.000000
	 DampenFactor=0.05
     DampenFactorParallel=0.600000
     DetonateDelay=1.250000
     DetonateOn=DT_ImpactTimed
     DrawScale=0.500000
     ImpactDamage=25
	 ImpactDamageType=Class'BWBP_SKC_Pro.DT_LonghornShotDirect'
     ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornCluster'
     LifeSpan=20
     LightBrightness=32.000000
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightRadius=4.000000
     LightSaturation=192
     LightType=LT_Steady
     MomentumTransfer=15000.000000
     MotionBlurFactor=3.000000
     MotionBlurRadius=384.000000
     MotionBlurTime=1.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_LonghornShotRadius'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_LonghornShotRadius'
     RotationRate=(Roll=32768)
     ShakeRadius=512.000000
     PlayerImpactType=PIT_Detonate
     Speed=3800.000000
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Longhorn.ClusterProj'
     TrailClass=Class'BWBP_SKC_Pro.LonghornGrenadeTrailSmall'
	 ModeIndex=1
}
