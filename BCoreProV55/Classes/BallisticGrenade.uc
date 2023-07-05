//=============================================================================
// BallisticGrenade.
//
// General purpose grenade for ballistic weapons.
// They travel in an arc, bounce off walls and can react differently depending
// on their settings. New features include: different detonation conditions,
// abliity to stick to or bounce off enemies (and friends). Also trail,
// alignment, effect and flak settings.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticGrenade extends BallisticProjectile
	abstract;

var() 	GrenadeEffectParams.EDetonateType		UnarmedDetonateOn;
var() 	GrenadeEffectParams.EDetonateType 		ArmedDetonateOn;

var  	GrenadeEffectParams.EDetonateType		DetonateOn;

var() 	GrenadeEffectParams.EPlayerImpactType	UnarmedPlayerImpactType;
var() 	GrenadeEffectParams.EPlayerImpactType	ArmedPlayerImpactType;

var 	GrenadeEffectParams.EPlayerImpactType 	PlayerImpactType;

var() class<BCImpactManager>	ReflectImpactManager;
var() float						DampenFactor;			// Bounce Damping
var() float						DampenFactorParallel;	// Parallel Bounce Damping
var() float						PawnDampAdjust;			// Multiplies dampen factors against pawns
var() float						RandomSpin;				// Random spin amount
var() bool						bNoInitialSpin;			// Do not apply random spin until impact
var() bool						bAlignToVelocity;		// If true, grenaded always faces in the direction of its velocity
var	  bool						bHasImpacted;			// Has it hit anything yet?
//var	  bool					bCanHitOwner;			// Can impact with owner

var() float						ArmingDelay;			// Time before switching to armed handling.
var() bool						bArmed;					// Grenade is armed
var() float 					DetonateDelay;			// Time before detonation. Starts on spawn for DT_Timer. Starts on impact for DT_ImpactTimed

var() int						FlakCount;				// How many chunks of flak to fling on explode
var() Class<Projectile>			FlakClass;				// Flak projectiles to fling on explode

var() bool						TrailWhenStill;			// If true, trail actor stays when not moving

var() int						ImpactDamage;			// Damage when hitting or sticking to players and not detonating
var() Class<DamageType>			ImpactDamageType;		// Type of Damage caused for striking or sticking to players
var() float						MinStickVelocity;		// Minimum velocity required to stick to players
var() float						StillSpeed;				// Speed below which grenade is considered still

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

    if (RandomSpin != 0 && !bNoInitialSpin)
        RandSpin(RandomSpin);
}

simulated function ApplyParams(ProjectileEffectParams params)
{
    local GrenadeEffectParams gren_params;

    Super.ApplyParams(params);

    gren_params = GrenadeEffectParams(params);

    if (gren_params != None)
    {
		ImpactDamage = gren_params.ImpactDamage;
		default.ImpactDamage = gren_params.ImpactDamage;
		
		if (gren_params.bOverrideArming)
		{
			ArmingDelay = gren_params.ArmingDelay;

			UnarmedDetonateOn = gren_params.UnarmedDetonateOn;

			ArmedDetonateOn = gren_params.ArmedDetonateOn;

			UnarmedPlayerImpactType = gren_params.UnarmedPlayerImpactType;

			ArmedPlayerImpactType = gren_params.ArmedPlayerImpactType;

			DetonateDelay = gren_params.DetonateDelay;
			default.DetonateDelay = gren_params.DetonateDelay;
		}
	}
	
	if (ArmingDelay > 0)
	{
		DetonateOn = UnarmedDetonateOn;
		PlayerImpactType = UnarmedPlayerImpactType;
		SetTimer(ArmingDelay, false);
	}
	else
	{
		Arm();

		if (DetonateOn == DT_Timer)
        	SetTimer(DetonateDelay, false);
	}
}

simulated function Arm()
{
	
	if (UnarmedDetonateOn == DT_Disarm && bHasImpacted) //Don't arm if we hit a wall in disarm window
	{
		DestroyEffects();
		Destroy();
		return;
	}
	bArmed = true;
	DetonateOn = ArmedDetonateOn;
	PlayerImpactType = ArmedPlayerImpactType;
}

simulated event Timer()
{
	if (!bArmed)
	{
		Arm();
		return;
	}

	Explode(Location, vect(0,0,1));
}

// Destroy effects
simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
			Emitter(Trail).Kill();
		else
			Trail.Destroy();
	}
}

// Make the thing look like its pointing in the direction its going
simulated event Tick( float DT )
{
	if (bAlignToVelocity && ( RandomSpin == 0 || (bNoInitialSpin && !bHasImpacted) ))
		SetRotation(Rotator(Velocity));
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, None );
}

simulated event UsedBy( Pawn User )
{
	if (User == Base)
	{
		bCanHitOwner = False;
		SetBase (None);
		SetPhysics(PHYS_Falling);
		Velocity = -Vector(Rotation)*200;
	}
}

singular function BaseChange()
{
	if (Base == None)
	{
		SetPhysics(PHYS_Falling);
	}
}

simulated function bool CanTouch(Actor Other)
{
    if (Base != None)
        return false;

    return Super.CanTouch(Other);
}

simulated function ApplyImpactEffect(Actor Other, Vector HitLocation)
{
    if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

    if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
        class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, GetMomentumVector(Normal(Velocity)), ImpactDamageType);
    else 
        class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, GetMomentumVector(Normal(Velocity)), ImpactDamageType);
}

//===============================================================
// Impact
//
// Called when a projectile has struck an actor directly, after 
// ApplyImpactEffect is used to affect that actor (damage, DoT, etc)
//
// Returns true if the function has handled the projectile's 
// future behaviour. Returns false if the projectile should 
// explode instead.
//===============================================================
simulated function bool Impact(Actor Other, Vector HitLocation)
{
    local float BoneDist;

    if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
	{
		Explode(HitLocation, Normal(HitLocation-Other.Location));
	}
	else if ( PlayerImpactType == PIT_Bounce || (PlayerImpactType == PIT_Stick && (VSize (Velocity) < MinStickVelocity)) )
	{
		HitWall (Normal(HitLocation - Other.Location), Other);
	}
	else if ( PlayerImpactType == PIT_Stick && Base == None )
	{
		SetPhysics(PHYS_None);
		if (DetonateOn == DT_ImpactTimed)
		{
			bArmed = True;
			SetTimer(DetonateDelay, false);
		}
		if (Other != Instigator && Other.DrawType == DT_Mesh)
			Other.AttachToBone( Self, Other.GetClosestBone( Location, Velocity, BoneDist) );
		else
			SetBase (Other);

		SetRotation (Rotator(Velocity));
		Velocity = vect(0,0,0);
	}

    return true;
}

// don't override - use DampenFactor and DampenFactorParallel
simulated function HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

	if (DetonateOn == DT_Impact)
	{
		Explode(Location, HitNormal);
		return;
	}

	if (DetonateOn == DT_ImpactTimed && !bHasImpacted)
    {
		bArmed = True;
		SetTimer(DetonateDelay, false);
    }

	if (Pawn(Wall) != None)
	{
		DampenFactor *= PawnDampAdjust;
		DampenFactorParallel *= PawnDampAdjust;
	}

	bCanHitOwner=true;
	bHasImpacted=true;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * DampenFactor + (Velocity - VNorm) * DampenFactorParallel;

	if (RandomSpin != 0)
		RandSpin(100000);
	Speed = VSize(Velocity);

	if (Speed < StillSpeed)
	{
		bBounce = False;
		SetPhysics(PHYS_None);

		if (DetonateOn == DT_Still)
		{
			bArmed = True;
			SetTimer(DetonateDelay, false);
		}

		if (Trail != None && !TrailWhenStill)
		{
			DestroyEffects();
		}
	}
	else if (Pawn(Wall) == None && (Level.NetMode != NM_DedicatedServer) && (Speed > 100) && !Level.bDropDetail && EffectIsRelevant(Location,false))
	{
		if (ImpactSound != None)
			PlaySound(ImpactSound, SLOT_Misc, 1.5 );
		if (ReflectImpactManager != None)
		{
			if (Instigator == None)
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ReflectImpactManager.static.StartSpawn(Location, HitNormal, Wall.SurfaceType, Instigator);			
		}
    }
}

simulated function BlowUp(vector HitLocation)
{
	local vector Start;
    local rotator Dir;
    local int i;

	Start = Location/* + 10 * HitNormal*/;
	if (FlakCount > 0 && FlakClass != None)
	{
		for (i=0;i<FlakCount;i++)
		{
			Dir.Yaw += FRand()*40000-20000;
			Dir.Pitch += FRand()*40000-20000;
			Spawn( FlakClass,, '', Start, Dir);
		}
	}
	TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	if ( Role == ROLE_Authority )
		MakeNoise(1.0);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Actor A;
	local Vector HitLoc, HitNorm, End;
	
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
	
	End.Z = -DamageRadius;
	
	A = Trace(HitLoc, HitNorm, End, , False);

    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}

	if (bTearOnExplode && !bNetTemporary && Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GotoState('NetTrapped');
	}
	
	else Destroy();
}

defaultproperties
{
    DampenFactor=0.05000
    DampenFactorParallel=0.350000
	PawnDampAdjust=0.25
    RandomSpin=32768.000000
    DetonateDelay=3.000000
    FlakClass=Class'XWeapons.FlakChunk'
    TrailWhenStill=True
    MinStickVelocity=200.000000
    Speed=1000.000000
    Damage=70.000000
    DamageRadius=240.000000
    MomentumTransfer=75000.000000
    Physics=PHYS_Falling
    DrawScale=8.000000
    bHardAttach=True
    bBounce=True
    bFixedRotationDir=True
    RotationRate=(Roll=10000)
	StillSpeed=10
}
