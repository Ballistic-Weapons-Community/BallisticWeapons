//=============================================================================
// LonghornClusterGrenadeNoDud. Used in Classic
//
// Feature packed low explosive grenade that spawns cluster bombs on detonate
// Has fuse that starts on first bounce, or can be detonated manually for less
// damage but more knockback. If in flight long enough without bouncing it does
// more damage and spawns more powerful impact detonating clusters for artillery.
//
// Spawns shrapnel at all ranges
//
// by Casey "Xavious" Johnson and Azarael
// Copyright(c) 2012 Casey Johnson. All Rights Reserved.
//=============================================================================
class LonghornClusterGrenadeNoDud extends BallisticGrenade;

var bool                 bColored;
var bool                 bPrimaryGrenade;
var bool                 bFireReleased;
var bool                 bNoArtillery, bArtillerate;
var float                ZBonus;

replication
{
	reliable if (bTearOff && Role == ROLE_Authority)
		bArtillerate;
}

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

simulated function InitProjectile ()
{
		Velocity = Speed * Vector(VelocityDir);
		if (RandomSpin != 0 && !bNoInitialSpin)
			RandSpin(RandomSpin);
		if (DetonateOn == DT_Timer)
			SetTimer(DetonateDelay, false);
}

simulated event TornOff()
{
	Explode(Location, vect(0,0,1));
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
            NewMomentum.Z += ZBonus * (DamageScale + 0.10);
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

function ManualDetonate(bool bBig)
{
	if (bBig)
	{
	   FlakClass=Class'BWBP_SKC_Pro.LonghornMicroClusterImpact';
       Damage*=2.00;
       DamageRadius*=2.00;
	   bArtillerate = True;
	 }
	else
	{
//		Damage = Default.Damage * 0.9;
		MomentumTransfer = Default.MomentumTransfer * 1.50;
		ZBonus = Default.ZBonus * 1.5;
	}
	
	Explode(Location, vect(0,0,1));
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

	if (Role == ROLE_Authority) // server will manage detonation for Longhorn primary
	{
		if (DetonateOn == DT_Impact)
		{
			Explode(Location, HitNormal);
			return;
		}
		else if (DetonateOn == DT_ImpactTimed && bFireReleased && !bHasImpacted)
		{
			SetTimer(DetonateDelay, false);
		}
		if (Pawn(Wall) != None)
		{
			DampenFactor *= 0.5;
			DampenFactorParallel *= 0.5;
		}
	}
	bCanHitOwner=true;
	if(bFireReleased)
		bHasImpacted=true;
	bNoArtillery=True;
	

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

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;
		
	if (xPawn(Other) != None && !xPawn(Other).bProjTarget)
	{
		HitWall(Normal(Location - xPawn(Other).Location), Other);
		return;
	}
		
	if(Pawn(Other) != None)
	{
        	Velocity *= 0.5; // Clusters don't bounce as far off of players
    		if (Role == ROLE_Authority && Pawn(Other).Physics == PHYS_Falling && Other != Instigator) // Bonus damage for hitting enemies in air
		    	class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage*0.5, Instigator, HitLocation, Velocity, ImpactDamageType);
	}
	// Do damage for direct hits
	if (Role == ROLE_Authority && HitActor != Other)		
		DoDamage(Other, HitLocation);
			
	if (Role == ROLE_Authority)
	{	
		// Spawn projectile death effects and try radius damage
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	
	if (bExploded)
		return;
	
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
	
	if (bArtillerate)
	    ImpactManager=Class'IM_LonghornMax';
		
	if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	
	if (!bTearOff)
		BlowUp(HitLocation);
	bExploded = True;
	
	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
	{
		bTearOff = true;
	}
	
	else Destroy();
}

function BlowUp(vector HitLocation)
{
	local vector Start, X,Y,Z;;
    local rotator Dir;
    local int i;
    GetAxes(Rotation,X,Y,Z);
	Start = Location;
	if (!FastTrace(Location - vect(0,0,32)))
		Start.Z += 16;
	if (FlakCount > 0 && FlakClass != None)
	{
		for (i=0;i<FlakCount;i++)
		{
			Dir.Yaw += 20000 + FRand() * 40000;
			Dir.Pitch = -7000 - Rand(7000);
            Spawn( FlakClass,, '', Start, Dir);
        }
	}
	TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

defaultproperties
{
     bAlignToVelocity=True
     bDynamicLight=True
     bNetTemporary=False
     bNoInitialSpin=True
     bPrimaryGrenade=True
     Damage=70
     DamageRadius=450.000000
     DampenFactor=0.400000
     DampenFactorParallel=0.500000
     DetonateDelay=0.65
     DetonateOn=DT_ImpactTimed
     PlayerImpactType=PIT_Detonate
     DrawScale=0.500000
     FlakClass=Class'BWBP_SKC_Pro.LonghornMicroClusterFlak'
     flakcount=6
     ImpactDamage=70
     ImpactDamageType=Class'BWBP_SKC_Pro.DT_LonghornBigDirect'
     ImpactManager=Class'BWBP_SKC_Pro.IM_SMARTGrenade'
     LifeSpan=20
     LightBrightness=64.000000
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightRadius=8.000000
     LightSaturation=192
     LightType=LT_Steady
     MomentumTransfer=20000.000000
     MotionBlurFactor=3.000000
     MotionBlurRadius=384.000000
     MotionBlurTime=4.000000
     MyDamageType=Class'BWBP_SKC_Pro.DT_LonghornBigRadius'
     MyRadiusDamageType=Class'BWBP_SKC_Pro.DT_LonghornBigRadius'
     RotationRate=(Roll=32768)
     ShakeRadius=512.000000
     Speed=3500.000000
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     StaticMesh=StaticMesh'BWBP_SKC_Static.Longhorn.GrenadeProj'
     TrailClass=Class'BWBP_SKC_Pro.LonghornGrenadeTrail'
     ZBonus=40000.00
}
