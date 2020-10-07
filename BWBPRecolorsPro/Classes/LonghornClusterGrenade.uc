//=============================================================================
// LonghornClusterGrenade.
//
// Feature packed low explosive grenade that spawns cluster bombs on detonate
// Has fuse that starts on first bounce, or can be detonated manually for less
// damage but more knockback. If in flight long enough without bouncing it does
// more damage and spawns more powerful impact detonating clusters for artillery.
//
// Initially written by Casey "Xavious" Johnson 
// and fixed up by Azarael
// Copyright(c) 2012 Casey Johnson. All Rights Reserved.
//=============================================================================
class LonghornClusterGrenade extends BallisticGrenade;

var bool                 				bColored;
var bool                					bPrimaryGrenade;
var bool                 				bFireReleased;
var bool                 				bNoArtillery;
enum EDetonationType
{
	DET_Shatter,
	DET_Manual,
	DET_Big
};

var EDetonationType				DetonationType; //1:manual 2:artillery
var float                				ZBonus;
var float								DamageDropoffFactor;
var int									ExplosiveImpactDamage;
var protected const float		ArmingDelay;

replication
{
	reliable if (bTearOff && Role == ROLE_Authority)
		DetonationType;
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
		if(Instigator != None && LonghornGrenadeTrail(Trail) != None)
			LonghornGrenadeTrail(Trail).SetupColor(Instigator.GetTeamNum());
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
}

simulated event TornOff()
{
	Explode(Location, vect(0,0,1));
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, DmgRadiusScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
			if (!FastTrace(Victims.Location, Location))
			{
				if (!bCoverPenetrator)
					continue;
				else DmgRadiusScale = (DamageRadius - GetCoverReductionFor(Victims.Location)) / DamageRadius;
				
				if (DamageRadius * DmgRadiusScale < 16)
					continue;
			}
			else DmgRadiusScale = 1;
			
			dir = Victims.Location;
			if (Victims.Location.Z > HitLocation.Z)
				dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
			else dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
			dir -= HitLocation;
			dist = FMax(1,VSize(dir));
			if (bCoverPenetrator && DmgRadiusScale < 1 && VSize(dir) > DamageRadius * DmgRadiusScale)
				continue;
			dir = dir/dist;
			damageScale = 1 - FClamp(((dist - Victims.CollisionRadius) - (DamageRadius * DmgRadiusScale *  DamageDropOffFactor)) / (DamageRadius * DmgRadiusScale * (1-DamageDropOffFactor)), 0, 1);
			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				Square(damageScale) * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

function ManualDetonate(bool bBig)
{
	if (bFireReleased)
		return;
	
	if (bBig)
	{
		FlakClass=Class'LonghornClusterGrenadeImpact';
		DamageRadius *= 2;
		DetonationType = DET_Big;
	 }
	else
	{
		FlakClass=Class'LonghornClusterGrenadeFlak';
		Damage = 60;
		DetonationType = DET_Manual;
		MomentumTransfer=20000;
	}
	
	Explode(Location, vect(0,0,1));
}

simulated event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

	if (Role == ROLE_Authority) // server will manage detonation for Longhorn primary
	{
		if (DetonateOn == DT_Impact || (DetonateOn == DT_ImpactTimed && bFireReleased && !bHasImpacted))
		{
			if (ImpactSound != None)
				PlaySound(ImpactSound, SLOT_None , , ,TransientSoundRadius * FMin(Speed/3500,1));
			Explode(Location, HitNormal);
			return;
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
		Damage = 75;
		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && (!Level.bDropDetail) && (Level.DetailMode != DM_Low) && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_None , , ,TransientSoundRadius * FMin(Speed/3500,1));
		if (ReflectImpactManager != None)
		{
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);			
		}
    }
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector ReflectNorm, VNorm;
	
	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;
		
	if (xPawn(Other) != None && !xPawn(Other).bProjTarget)
	{
		HitWall(Normal(Location - xPawn(Other).Location), Other);
		return;
	}

	// Do damage for direct hits
	if (Role == ROLE_Authority && HitActor != Other)		
	{
		HitActor = Other;
		if (!bHasImpacted && !bFireReleased && default.LifeSpan - LifeSpan > ArmingDelay)
		{
			class'BallisticDamageType'.static.GenericHurt (Other, ExplosiveImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
			DetonationType = DET_Big;
			Explode(HitLocation, vect(0,0,1));
		}
		else 
		{
			class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage * VSize(Velocity) / MaxSpeed, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
			ReflectNorm = Location - Other.Location;
			ReflectNorm.Z = 0;
			ReflectNorm = Normal(ReflectNorm);
			
			VNorm = (Velocity dot ReflectNorm) * ReflectNorm;
			Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;
			
			bHasImpacted = True;
			bFireReleased = True;
			Explode(HitLocation, vect(0,0,1));
		}
	}
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	
	if (bExploded)
		return;
	
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
	
	if (DetonationType == DET_Shatter)
		ImpactManager = None;

	else if (DetonationType == DET_Big)
	{
	    ImpactManager=Class'IM_LonghornMax';
		if (DamageRadius == default.DamageRadius)
			FlakClass = None;
	}
		
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
	
	if (!bNetTemporary && bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else Destroy();
}

function BlowUp(vector HitLocation)
{
	local vector Start, X,Y,Z;
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
			if (DetonationType == DET_Shatter)
				Dir = RotRand();
			else
			{
				Dir.Yaw += 20000 + FRand() * 40000;
				Dir.Pitch = -12386 - Rand(4000);
			}
			Spawn( FlakClass,, '', Start, Dir);
		}
	}
	
	if (DetonationType != DET_Shatter)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

defaultproperties
{
     bPrimaryGrenade=True
     ZBonus=40000.000000
     DamageDropoffFactor=0.100000
     ExplosiveImpactDamage=150
     ArmingDelay=0.180000
     DetonateOn=DT_ImpactTimed
     PlayerImpactType=PIT_Detonate
     DampenFactor=0.300000
     DampenFactorParallel=0.400000
     bNoInitialSpin=True
     bAlignToVelocity=True
     flakcount=6
     FlakClass=Class'BWBPRecolorsPro.LonghornClusterGrenadeDud'
     ImpactDamage=100
     ImpactDamageType=Class'BWBPRecolorsPro.DT_LonghornBigDirect'
     ImpactManager=Class'BWBPRecolorsPro.IM_SMARTGrenade'
	 ReflectImpactManager=Class'BallisticProV55.IM_GunHit'
     TrailClass=Class'BWBPRecolorsPro.LonghornGrenadeTrail'
     MyRadiusDamageType=Class'BWBPRecolorsPro.DT_LonghornBigRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=512.000000
     MotionBlurRadius=384.000000
     MotionBlurFactor=3.000000
     MotionBlurTime=4.000000
     bCoverPenetrator=True
     Speed=6000.000000
     MaxSpeed=6000.000000
     Damage=150.000000
     DamageRadius=450.000000
     MomentumTransfer=100000.000000
     MyDamageType=Class'BWBPRecolorsPro.DT_LonghornBigRadius'
     ImpactSound=SoundGroup'BallisticSounds2.NRP57.NRP57-Metal'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=25
     LightSaturation=192
     LightBrightness=64.000000
     LightRadius=12.000000
     StaticMesh=StaticMesh'BallisticRecolors4StaticProExp.Longhorn.GrenadeProj'
     bDynamicLight=True
     bNetTemporary=False
     AmbientSound=Sound'GeneralAmbience.texture12'
     LifeSpan=20.000000
     DrawScale=0.500000
     bFullVolume=True
     SoundVolume=255
     SoundPitch=32
     SoundRadius=512.000000
     TransientSoundVolume=0.700000
     TransientSoundRadius=1024.000000
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     RotationRate=(Roll=32768)
}
