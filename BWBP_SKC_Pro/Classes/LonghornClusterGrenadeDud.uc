//=============================================================================
// LonghornClusterGrenadeAlt.
//
// Small cluster bomb used by alt fire. Moves very fast but otherwise behaves
// very much like LonghornClusterGrenadeFlak.
//
// by Casey "Xavious" Johnson.
// Copyright(c) 2012 Casey Johnson. All Rights Reserved.
//=============================================================================

class LonghornClusterGrenadeDud extends BallisticGrenade;

var	Emitter				Flare;
var	class<Emitter> 	    FlareClass;
var	bool				bFlareKilled;

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
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

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight; // Set up some effects, team colored
	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		Flare = Spawn(FlareClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if(Instigator != None && LonghornGrenadeTrailAlt(Trail) != None)
			LonghornGrenadeTrailAlt(Trail).SetupColor(Instigator.GetTeamNum());
		if (Trail != None)
		{
			if (Emitter(Trail) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
			Trail.SetBase (self);
		}
		if (Flare != None)
		{
			class'BallisticEmitter'.static.ScaleEmitter(Flare, DrawScale);
			Flare.SetBase (self);
		}
	}
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

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

	if (Speed < 10)
	{
		bBounce = False;
		SetPhysics(PHYS_None);
		DestroyEffects();
		Destroy();
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc );
		if (ImpactManager != None)
			ImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Owner);
    }
}

simulated function ApplyImpactEffect(Actor Other, vector HitLocation)
{
    class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
}

simulated function bool Impact (Actor Other, vector HitLocation)
{
    Destroy();
    return true;
}

// Destroy effects
simulated function DestroyEffects()
{
	if (Flare != None)
	{
		Flare.Kill();
		bFlareKilled=True;
	}
	if (Emitter(Trail) != None)
		Emitter(Trail).Kill();
}

simulated function Destroyed()
{
	if (Flare != None && !bFlareKilled)
		Flare.Destroy();
	if (Emitter(Trail) != None)
		Emitter(Trail).Kill();
	Super.Destroyed();
}

defaultproperties
{
    WeaponClass=Class'BWBP_SKC_Pro.LonghornLauncher'
     FlareClass=Class'BWBP_SKC_Pro.LonghornClusterFlare'
     DetonateOn=DT_None
     DampenFactor=0.120000
     DampenFactorParallel=0.250000
     bAlignToVelocity=True
     DetonateDelay=1.250000
     ImpactManager=Class'BWBP_SKC_Pro.IM_LonghornCluster'
     TrailClass=Class'BWBP_SKC_Pro.LonghornGrenadeTrailAlt'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_LonghornShotRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=128.000000
     MotionBlurFactor=1.000000
     MotionBlurTime=0.000000
     Speed=750.000000
     MaxSpeed=750.000000
     Damage=15.000000
     DamageRadius=32.000000
     MomentumTransfer=25000.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_LonghornShotDirect'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=192
     LightBrightness=32.000000
     LightRadius=4.000000
     StaticMesh=StaticMesh'BWBP_SKC_Static.Longhorn.ClusterProj'
     bDynamicLight=True
     LifeSpan=3.000000
     DrawScale=0.500000
     bCollideActors=False
     RotationRate=(Roll=32768)
}
