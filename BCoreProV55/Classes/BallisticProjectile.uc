//=============================================================================
// BallisticProjectile.
//
// An extended base for projectiles. Features:
// -ImpactManager for Explodes with suport for surface specific effects
// -Player Penetration with impact manager for efect
// -Delayed start
// -Trail spawning
// -Radius damage
// -Area specific damage for headshots/limbshots with random damage ranges
// -Splashing with impact manager for effect
// -View shaking for nearby players when exploding
//
// Azarael edits:
// - Fixed offset bug.
// - Fixed double / triple damage bug.
// - Modified TearOff code, not sure if this works compared to version defined in subclass


//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticProjectile extends Projectile
	abstract
    DependsOn(ProjectileEffectParams)
	config(BallisticProV55);

const HEAD_RADIUS = 7;
const TORSO_RADIUS = 12;
const MAX_MOMENTUM_Z = 10000.0f;

//=============================================================================
// STATE VARIABLES
//=============================================================================
var	    Actor					Trail;					// The trail Actor
var     Actor					HitActor;				// Actor that got hit directly
var     bool					bCanHitOwner;			// Bounced or turned around or something so it can hit owner
var     bool					bExploded;				// Already Blown up. Used by troublesome rocekts that keep going off on clients
var     Vector                  TearOffHitNormal;
var		bool					bApplyParams;			// Apply params to this projectile (allows separation for projectiles such as flak classes)
//=============================================================================
// END STATE VARIABLES
//=============================================================================

//=============================================================================
// GENERAL PROJECTILE VARIABLES
//
// These variables are consistent for every instance of a projectile and are 
// user-defined but generally not modified within the game. 
//=============================================================================
//-----------------------------------------------------------------------------
// Appearance
//-----------------------------------------------------------------------------
var() class<BallisticWeapon>    WeaponClass;            // required, in order to query its parameters
var() class<BCImpactManager>    ImpactManager;			// Impact manager to spawn on final hit
var() class<BCImpactManager>    PenetrateManager;		// Impact manager to spawn when going through actors
var() class<BCImpactManager>    SplashManager;			// Impact manager to spawn for splashes
var() class<Actor>			    TrailClass;				// Actor to use for trail
var() Vector				    TrailOffset;			// Offset from location at which to spawn trail
var() bool					    bRandomStartRotation;	// Set random roll on startup
//-----------------------------------------------------------------------------
// Handling
//-----------------------------------------------------------------------------
var() int                       ModeIndex;              // For parameter indexing - is primary or alt fire shot
var() byte                      LayoutIndex;            // For parameter indexing - layout of firing weapon
var() byte                      CurrentWeaponMode;      // For parameter indexing - fire mode index of firing weapon
var() bool					    bCheckHitSurface;		// Check impact surfacetype on explode for surface dependant ImpactManagers
var() bool					    bPenetrate;				// Will go through enemies

// this property (StartDelay) and its associated handling should be abolished.
// it is designed to simulate a delay between the action of a firemode animation (grenade throw)
// and the spawning of the projectile from that action
// however, the projectile is spawned and hidden at the _start_ of the action (from the idle position)
// and receives its velocity and rotation at that time
// this causes the aim to be off, as it's calculated from where the fire action began
// the correct way to handle this is to give the fire mode a prefire time and animation
// and leave the projectile alone
var() float					    StartDelay;				// Used to delay projectile's entry into the world


var() bool					    bTearOnExplode;			// If not NetTemporary, tear this projectile off when it explodes
var() float					    NetTrappedDelay;		// How long to remain in nettrapped state before being destroyed
//-----------------------------------------------------------------------------
// Damage
//-----------------------------------------------------------------------------
var() class<DamageType>		    DamageTypeHead;			// Damagetype for headshots
var() class<DamageType>		    DamageTypeLimb;			// Damagetype for limbshots
var() class<DamageType>		    MyRadiusDamageType;		// DamageType to use for splash damage
var() bool                      bLimitMomentumZ;        // Prevents Z momentum exceeding certain value
var() bool					    bUsePositionalDamage;	// Enable damage variation depending on hitlocation
var() float                     WallPenetrationForce;
//-----------------------------------------------------------------------------
// AI
//-----------------------------------------------------------------------------
var() bool					    bWarnEnemy;				// Warn enemies that it's coming for em
//-----------------------------------------------------------------------------
// View Shake
//-----------------------------------------------------------------------------
var() float	 				    ShakeRadius;			// Shake the view of players withing this radius when Exploding
var() vector                    ShakeRotMag;           // how far to rot view
var() vector                    ShakeRotRate;          // how fast to rot view
var() float                     ShakeRotTime;          // how much time to rot the instigator's view
var() vector                    ShakeOffsetMag;        // max view offset vertically
var() vector                    ShakeOffsetRate;       // how fast to offset view vertically
var() float                     ShakeOffsetTime;       // how much time to offset view
//-----------------------------------------------------------------------------
// Blur
//-----------------------------------------------------------------------------
var() float					    MotionBlurRadius;
var() float					    MotionBlurFactor;
var() float					    MotionBlurTime;
//=============================================================================
// END GENERAL PROJECTILE VARIABLES
//=============================================================================

//=============================================================================
// GAMEPLAY VARIABLES
//
// These variables are user-defined, and may additionally be modified either 
// by the game ruleset or by weapon modes and attachments.
//=============================================================================
//-----------------------------------------------------------------------------
// Handling
//-----------------------------------------------------------------------------
var() float					    AccelSpeed;				// Acceleration speed
var() Rotator					StartRotation;			// Initial rotation of the projectile (allows for path manipulation based on an initial reference frame)
//-----------------------------------------------------------------------------
// Damage
//-----------------------------------------------------------------------------
// positional damage modifiers
var() float					    HeadMult;		        // Multiplier for effect against head
var() float					    LimbMult;		        // Multiplier for effect against limb
// damage over range
var() float                     MaxDamageGainFactor;
var() float                     DamageGainStartTime;
var() float                     DamageGainEndTime;
// radius damage
var() ProjectileEffectParams.ERadiusFallOffType        RadiusFallOffType;
//=============================================================================
// END GAMEPLAY VARIABLES
//=============================================================================

// struct to avoid forced compression of rotators, if we need to start the projectile after a delay
var struct NetInitialRot
{
    var int Pitch;
    var int Yaw;
    var int Roll;
} NetInitialRotation;

replication
{
    reliable if (bNetInitial && Role == ROLE_Authority)
        LayoutIndex, CurrentWeaponMode;
    reliable if (bNetInitial && Role == ROLE_Authority && bNetInitialRotation)
        NetInitialRotation;
	reliable if (bTearOff && Role == ROLE_Authority)
		TearOffHitNormal;
}

//===================================================================
// UpdateNetRotation
// 
// Updates the initial rotation that clients acquiring this projectile 
// will see.
//===================================================================
final function UpdateNetRotation()
{
    NetInitialRotation.Pitch = Rotation.Pitch;
    NetInitialRotation.Yaw = Rotation.Yaw;
    NetInitialRotation.Roll = Rotation.Roll;
}

//===================================================================
// PostBeginPlay
//
// Sets the replicated parameters required to derive properties on 
// the client, binds the projectile parameters and applies initial 
// speed on the server.
//===================================================================
simulated function PostBeginPlay()
{
    Super(Projectile).PostBeginPlay();

    if (Level.NetMode == NM_Client)
        return;

    // bind replicated parameters for indexing on client
    if (Instigator != None && BallisticWeapon(Instigator.Weapon) != None)
    {
        CurrentWeaponMode = BallisticWeapon(Instigator.Weapon).CurrentWeaponMode;
        LayoutIndex = BallisticWeapon(Instigator.Weapon).LayoutIndex;
    }

    // replicate uncompressed rotation to client as part of initial state
    UpdateNetRotation();

    InitParams();

    if (StartDelay == 0)
        SetInitialSpeed(true);
}

//===================================================================
// PostNetBeginPlay
//
// Called after initial state has been replicated.
// Applies acceleration on clients.
//===================================================================
simulated function PostNetBeginPlay()
{
	local PlayerController PC;
    local Rotator R;
	
    if (Level.NetMode == NM_Client)
    {
        // apply UNCOMPRESSED rotation before deriving velocity and acceleration
        R.Pitch = NetInitialRotation.Pitch;
        R.Yaw = NetInitialRotation.Yaw;
        R.Roll = NetInitialRotation.Roll;

        SetRotation(R);

        InitParams();
        SetInitialSpeed();
    }

	if (StartDelay > 0)
	{
		if (Role == ROLE_Authority || bNetOwner || bAlwaysRelevant)
		{
            if (Level.NetMode == NM_Client)
            {
                //Log("Hiding "$Name$" for start delay on client");
            }

            HideForStartDelay();
			return;
		}
		
		else 
        {
            if (Level.NetMode == NM_Client)
            {
                //Log("Setting start delay for "$Name$" to 0");
            }
            StartDelay = 0;

        }
	}
	
	InitProjectile();
	
	if (Level.NetMode == NM_DedicatedServer)
		return;
        
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

//===================================================================
// InitParams
//
// Reads the game style for the parameters for this projectile and 
// applies them.
//===================================================================
simulated function InitParams()
{    
    WeaponClass.default.ParamsClasses[class'BallisticReplicationInfo'.default.GameStyle].static.SetProjectileParams(self);
}

//===================================================================
// ApplyParams
//
// Sets all projectile parameters.
//===================================================================
simulated function ApplyParams(ProjectileEffectParams params)
{
    Speed = params.Speed;
	default.Speed = params.Speed;
	
    AccelSpeed = params.AccelSpeed;    
	default.AccelSpeed = params.AccelSpeed;
	
    MaxSpeed = params.MaxSpeed;    
	default.MaxSpeed = params.MaxSpeed;

    if (Level.NetMode == NM_Client)
        return;

    Damage = params.Damage;
	default.Damage = params.Damage;
	
    DamageRadius = params.DamageRadius;
	default.DamageRadius = params.DamageRadius;
	
    MomentumTransfer = params.MomentumTransfer;
	default.MomentumTransfer = params.MomentumTransfer;

	bLimitMomentumZ = params.bLimitMomentumZ;
	default.bLimitMomentumZ = params.bLimitMomentumZ;
	
    HeadMult = params.HeadMult;
	LimbMult = params.LimbMult; 

    MaxDamageGainFactor = params.MaxDamageGainFactor;    
    DamageGainStartTime = params.DamageGainStartTime;    
    DamageGainEndTime = params.DamageGainEndTime;    
    RadiusFallOffType = params.RadiusFallOffType; 

	default.MaxDamageGainFactor = params.MaxDamageGainFactor;    
    default.DamageGainStartTime = params.DamageGainStartTime;    
    default.DamageGainEndTime = params.DamageGainEndTime;    
    default.RadiusFallOffType = params.RadiusFallOffType;    
}

//===================================================================
// SetInitialSpeed
//
// Initializes velocity, acceleration and some rotation.
//
// Optional parameter is for use in situations where the server 
// cannot replicate the desired velocity as part of initial rep
// (i.e. when there is a StartDelay). It causes the velocity 
// to be calculated and set on the client.
//===================================================================
simulated function SetInitialSpeed(optional bool force_speed)
{
    local Rotator R;

    // receive from server
    if (Level.NetMode != NM_Client || force_speed)
    {
        Velocity = Vector(Rotation) * Speed;
    }

    if (AccelSpeed > 0 && MaxSpeed > Speed)
    {
        Acceleration = Normal(Velocity) * AccelSpeed;
    }

	if(bRandomStartRotation)
	{
		R = Rotation;
		R.Roll = Rand(65536);
		SetRotation(R);
	}

	StartRotation = Rotation;
}

// Initialize projectile stuff. This will be delayed by StartDelay
simulated function InitProjectile ()
{
	InitEffects();
}

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	if (Level.NetMode != NM_DedicatedServer)
	{
		if (TrailClass != None && Trail == None)
		{
			GetAxes(Rotation,X,Y,Z);
			Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
			if (Emitter(Trail) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale);
			if (Trail != None)
				Trail.SetBase (self);
		}
	}
}

//===================================================================
// TornOff
//
// Called for non-NetTemporary projectiles when server 
// closes connection
//===================================================================
simulated event TornOff()
{
	Explode(Location, TearOffHitNormal);
}

//=======================================================================================================
// START DELAY
//
// Allows for spawning a projectile, hiding it immediately and then making it visible and applying 
// its physics after a delay.
//
// Used for grenades and other projectiles that should be delayed relative to when they are thrown.
//
// N.B. this isn't a great way to handle this, both because of its complexity and because the 
// thrown grenade will actually spawn from the position that you initially threw, rather than where 
// you currently are, which creates a error in position
//=======================================================================================================


simulated function HideForStartDelay()
{
    //Log("Hiding "$Name$" due to start delay of "$StartDelay);
    
    SetPhysics(PHYS_None);
    SetCollision (false, false, false);
    SetTimer(StartDelay, false);
    bDynamicLight=false;

    // interferes with replication
    if (Level.NetMode != NM_DedicatedServer)
        bHidden=true;
}

simulated function ShowAfterStartDelay()
{
    //Log("Showing "$Name$" due to start delay of "$StartDelay);

    // interferes with replication
    if (Level.NetMode != NM_DedicatedServer)
        bHidden=false;

    StartDelay = 0;
    SetPhysics(default.Physics);
    SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
    bDynamicLight=default.bDynamicLight;

    SetInitialSpeed(true);
    InitProjectile();
}

// When start delay ends, set all the properties that make it visible
simulated function Timer()
{
	if (StartDelay > 0)
	{
        //Log("Showing projectile due to start delay of "$StartDelay);

		ShowAfterStartDelay();
		return;
	}
}

// Returns false so that physics volumes don't play any sounds
simulated function bool CanSplash()
{
	return false;
//	return bReadyToSplash;
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	local Actor A;
	local vector HitLoc, HitNorm, Start, End;
	if (SplashManager != None && bReadyToSplash && NewVolume.bWaterVolume)
	{
		Start = Location - Velocity*(Level.TimeSeconds - LastRenderTime);
		End = Location;
		bTraceWater=true;
		A = Trace(HitLoc, HitNorm, End, Start, true);
		bTraceWater=false;
		if (A != NewVolume)
			HitLoc = Start;
		SplashManager.static.StartSpawn(HitLoc, Normal(-Velocity), 9, Instigator);
	}
}

simulated function CheckSurface(vector StartLocation, vector StartNormal, out int Surf, optional out Actor Wall)
{
	local Vector	HitLoc, HitNorm;
	local Material	HitMaterial;

	Wall = Trace(HitLoc, HitNorm, StartLocation - StartNormal*4, StartLocation + StartNormal*4, false,,HitMaterial);
	if (Wall == None)
		return;

	if (Vehicle(Wall) != None)
		Surf = 3;
	else if (HitMaterial == None)
		Surf = int(Wall.SurfaceType);
	else
		Surf = int(HitMaterial.SurfaceType);
}

simulated function Destroyed()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
			Emitter(Trail).Kill();
		else
			Trail.Destroy();
	}
	Super.Destroyed();
}

simulated function ShakeView(vector HitLocation)
{
	local PlayerController PC;
	local float Dist, ScaleFactor;

	PC = level.GetLocalPlayerController();
	if ( PC != None && PC.ViewTarget != None/* && PC.ViewTarget.Base != None */)
	{
		Dist = VSize(HitLocation - PC.ViewTarget.Location);
		if (Dist < MotionBlurRadius)
		{
			ScaleFactor = (MotionBlurRadius - Dist) / MotionBlurRadius;
			class'BC_MotionBlurActor'.static.DoMotionBlur(PC, MotionBlurFactor * ScaleFactor, MotionBlurTime * ScaleFactor);
		}
		if (Dist < ShakeRadius)
		{
			if (Dist < ShakeRadius/3)
				ScaleFactor = 1.0;
			else
				ScaleFactor = (ShakeRadius - Dist) / ShakeRadius;
			PC.ShakeView(ShakeRotMag*ScaleFactor, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*ScaleFactor, ShakeOffsetRate, ShakeOffsetTime);
		}
	}
}

simulated function Vector GetMomentumVector(Vector input)
{
    input *= MomentumTransfer;

    if (bLimitMomentumZ && input.Z > MAX_MOMENTUM_Z)
        input *= MAX_MOMENTUM_Z / input.Z;

    return input;
}

// Returns the amount by which MaxWallSize should be scaled for each surface type. Override in subclasses to change...
function float SurfaceScale (int Surf) 
{
	switch (Surf)
	{
		Case 0:/*EST_Default*/	return 0.5;
		Case 1:/*EST_Rock*/		return 0.5;
		Case 2:/*EST_Dirt*/		return 0.35;
		Case 3:/*EST_Metal*/	return 0.25;
		Case 4:/*EST_Wood*/		return 0.55;
		Case 5:/*EST_Plant*/	return 0.5;
		Case 6:/*EST_Flesh*/	return 1;
		Case 7:/*EST_Ice*/		return 0.75;
		Case 8:/*EST_Snow*/		return 1;
		Case 9:/*EST_Water*/	return 1;
		Case 10:/*EST_Glass*/	return 1;
		default:			    return 0.5;
	}
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	
	if (!bNetTemporary && Role != ROLE_Authority)
        return;
    
    if (bExploded)
		return;
		
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
		
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bCheckHitSurface)
			CheckSurface(HitLocation, HitNormal, Surf);
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, Instigator);
	}
	
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
	
	else 
		Destroy();

}

function HideProjectile()
{
    // Log("HideProjectile");

	SetPhysics(PHYS_None);
	bAlwaysRelevant=True; //required to force bTearOff update
	bHidden=True;
	SetTimer(StartDelay, false);
	bDynamicLight=false;
	AmbientSound=None;
}

state NetTrapped
{
	function BeginState()
	{
		HideProjectile();
		SetTimer(NetTrappedDelay, false);
	}
	event Timer ()
	{
		Destroy();
	}
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
	
	}
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;

	if (DamageRadius > 0)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
        
	MakeNoise(1.0);
}

//===============================================================
// ProcessTouch
//
// First-line function called when making contact with an Actor.
//===============================================================
simulated function ProcessTouch(Actor Other, Vector HitLocation)
{
    local bool bContinueAfterImpact;

    if (UnlaggedPawnCollision(Other) != None)
        Other = UnlaggedPawnCollision(Other).UnlaggedPawn;

    if (!CanTouch(Other))
        return;

    if (Other != HitActor)
    {
        // Do damage for direct hits
        if (Other.Role == ROLE_Authority)		
            ApplyImpactEffect(Other, HitLocation);

        HitActor = Other;

        bContinueAfterImpact = Impact(Other, HitLocation);

	    // Spawn projectile death effects and try radius damage
        if (!bContinueAfterImpact && Role == ROLE_Authority)
		    Explode(HitLocation, vect(0,0,1));
    }
}

//===============================================================
// CanTouch
//
// Returns whether this Actor is a valid touch for this projectile.
//===============================================================
simulated function bool CanTouch(Actor Other)
{
    return Other != None && (bCanHitOwner || (Other != Instigator && Other != Owner));
}

//===============================================================
// Penetrate
//
// Handles necessary adjustments for a projectile to be seen as 
// "penetrating" an Actor it's hit
//===============================================================
simulated function Penetrate(Actor Other, Vector HitLocation)
{
    local Vector X;

    X = Normal(Velocity);
    SetLocation(HitLocation + (X * (Other.CollisionHeight*2*X.Z + Other.CollisionRadius*2*(1-X.Z)) * 1.2));
    if ( EffectIsRelevant(Location,false) && PenetrateManager != None)
         PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, Other.SurfaceType, Owner, 4/*HF_NoDecals*/);
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
    if (!CanPenetrate(Other))
        return false;

    Penetrate(Other, HitLocation);

    return true;
}

//===============================================================
// HitWall
//
// Called when a projectile has struck an Actor classed as 
// either world geometry or a vehicle.
//===============================================================
simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local PlayerController PC;

	if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && (!Wall.bWorldGeometry || Wall.bCanBeDamaged) )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			Wall.TakeDamage( Damage, instigator, Location, GetMomentumVector(Normal(Velocity)), MyDamageType);
			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
	if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer)  )
	{
		if ( ExplosionDecal.Default.CullDistance != 0 )
		{
			PC = Level.GetLocalPlayerController();
			if ( !PC.BeyondViewDistance(Location, ExplosionDecal.Default.CullDistance) )
				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
			else if ( (Instigator != None) && (PC == Instigator.Controller) && !PC.BeyondViewDistance(Location, 2*ExplosionDecal.Default.CullDistance) )
				Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
		}
		else
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
	}
	HurtWall = None;
}

//===============================================================
// ApplyImpactEffect
//
// Called on the server when this projectile strikes a valid target.
//===============================================================
simulated function ApplyImpactEffect(Actor Other, vector HitLocation)
{
    DoDamage(Other, HitLocation);
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
    local Vector BoneTestLocation;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (xPawn(Other) != None)
	{
        BoneTestLocation = GetDamageHitLocation(Other);
		
		class'BallisticDamageType'.static.GenericHurt (GetDamageVictim(Other, BoneTestLocation, Normal(Velocity), Dmg, DT), Dmg, Instigator, HitLocation, GetMomentumVector(Normal(Velocity)), DT);
	}
	else class'BallisticDamageType'.static.GenericHurt (GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT), Dmg, Instigator, HitLocation, GetMomentumVector(Normal(Velocity)), DT);
}

simulated function bool CanPenetrate(Actor Other)
{
	if (!bPenetrate || Other == None || Other.bWorldGeometry || Mover(Other) != None || Vehicle(Other) != None || DestroyableObjective(Other) != None)
		return false;
	return true;
}

final function float GetDamageOverRangeFactor()
{
    if (default.LifeSpan - lifespan > DamageGainStartTime)
        return 1f + MaxDamageGainFactor * FMin(default.LifeSpan - lifespan - DamageGainStartTime, DamageGainEndTime) / DamageGainEndTime;
    return 1f;
}

// Actor can be Pawn-derived or UnlaggedPawnCollision
function Vector GetDamageHitLocation(Actor Other)
{	
    local Vector ClosestLocation;
    //local Vector BoneTestLocation;

	// Find a point on the victim's Z axis at the same height as the HitLocation.
	ClosestLocation = Other.Location;
	ClosestLocation.Z += (Location - Other.Location).Z;

    return class'BUtil'.static.GetClosestPointTo(ClosestLocation, Location, normal(Velocity));
}

function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	local string	Bone;
	local float		BoneDist;
	local Vector 	HitLocationMatchZ;
	local Pawn		DriverPawn;

	Dmg = Damage;
	DT = MyDamageType;

    if(UnlaggedPawnCollision(Other) != None)
        return GetDamageForCollision(UnlaggedPawnCollision(Other), HitLocation, Dir, Dmg, DT);

    if (DamageGainEndTime > 0)
        Dmg *= GetDamageOverRangeFactor();

	if (!bUsePositionalDamage || Monster(Other) != None)
		return Other;

	if (Pawn(Other) != None)
	{
		if (Vehicle(Other) != None)
		{
			// Try to relieve driver of his head...
			DriverPawn = Vehicle(Other).CheckForHeadShot(HitLocation, Dir, 1.0);

			if (DriverPawn != None)
			{
				Other = DriverPawn;
				Dmg *= HeadMult;

				if (DamageTypeHead != None)
					DT = DamageTypeHead;
			}
		}
		
		else
		{
			HitLocationMatchZ = HitLocation;
			HitLocationMatchZ.Z = Other.Location.Z;
			
			// Check for head shot
			Bone = string(Other.GetClosestBone(HitLocation, Dir, BoneDist, 'head', HEAD_RADIUS));
			if (InStr(Bone, "head") > -1)
			{
				Dmg *= HeadMult;

				if (DamageTypeHead != None)
					DT = DamageTypeHead;
			}
			
			// Limb shots
			else if (HitLocation.Z < Other.Location.Z - (Other.CollisionHeight/6) || VSize(HitLocationMatchZ - Other.Location) > TORSO_RADIUS) //accounting for groin region here
			{
				Dmg *= LimbMult;

				if (DamageTypeLimb != None)
					DT = DamageTypeLimb;
			}
		}
	}

	return Other;
}

/*
hit algo for unlagged collisions

- first extend to closest point to saved head location and check if in radius - if so, return head damage
- then extend to vector between head and body, check within radius - if so, return body damage
- else return limb damage
*/

final function Actor GetDamageForCollision(UnlaggedPawnCollision Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
    local Vector HeadPositionApprox;

    // must be approximated. animation sync online is simply too poor
    HeadPositionApprox = Other.Location;
    HeadPositionApprox.Z += Other.CollisionHeight;
    HeadPositionApprox.Z -= HEAD_RADIUS + 2;

    // fixme: try doing a crouch check too

    if (class'BUtil'.static.GetClosestDistanceTo(HeadPositionApprox, Location, Dir) <= HEAD_RADIUS)
    {
        Dmg *= HeadMult;
        DT = DamageTypeHead;
        return Other;
    }

    if (HitLocation.Z > Other.Location.Z - 5)
    {
        HitLocation.Z = Other.Location.Z;

        // Torso radius
        if (VSize(HitLocation - Other.Location) <= TORSO_RADIUS)
            return Other;
    }
    
    Dmg *= LimbMult;
    DT = DamageTypeLimb;
      
	return Other;
}

// Special HurtRadius function. This will hurt everyone except the chosen victim.
// Useful if you want to spare a directly hit enemy from the radius damage
function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;
    local bool can_see;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( Victims.bCanBeDamaged && (Victims != self) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim && Victims != HurtWall)
		{
            can_see = FastTrace(Victims.Location, Location);

			if (!can_see)
            {
                if (WallPenetrationForce == 0)
                    continue;
            }

            // UNDerwater EXplosion damage
            else if (PhysicsVolume.bWaterVolume && Victims.PhysicsVolume == PhysicsVolume)
                DamageRadius *= 3;

            damageScale = 1f;

            dir = Victims.Location;
            if (Victims.Location.Z > HitLocation.Z)
                dir.Z = FMax(HitLocation.Z, dir.Z - Victims.CollisionHeight);
            else 
                dir.Z = FMin(HitLocation.Z, dir.Z + Victims.CollisionHeight);
            dir -= HitLocation;
            dist = FMax(1, VSize(dir));
            dir /= dist;

            if (can_see)
            {
                if (RadiusFallOffType != RFO_None)
                    damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius) / DamageRadius);
                if (RadiusFallOffType == RFO_Quadratic)
                    damageScale = Square(damageScale);
            }
            else 
            {
                damageScale = GetPenetrationDamageScale(dir, dist);

                if (damageScale < 0.01f)
                    continue;

                if (RadiusFallOffType == RFO_Quadratic)
                    damageScale = Square(damageScale);
            }

			if ( Instigator == None || Instigator.Controller == None )
				Victims.SetDelayedDamageInstigatorController( InstigatorController );

			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				GetMomentumVector(damageScale * dir),
				DamageType
			);
		 }
	}
	bHurtEntry = false;
}

// Trace to find out how far towards the target we can get
// n.b. this code does not work correctly for grenades on the ground
function float GetPenetrationDamageScale(Vector dir, float dist)
{
	local int						WallCount, WallPenForce, WallPenDelta;
	local Vector					End, X, HitLocation, HitNormal, Start, LastHitLoc, ExitNormal;
	local Material					HitMaterial, ExitMaterial;
	local float						pwr;
	local Actor						Other, LastOther;

    // dist is the distance between explosion centre and target
    // pwr is the power the blast has left to reach the endpoint
	WallPenForce = WallPenetrationForce;

	pwr = DamageRadius;

	Start = Location;
	X = Normal(Dir);
	End = Start + X * dist;
	LastHitLoc = End;

	bTraceWater=true;

	while (dist > 0 && pwr > 0)		// Loop traces in case we need to go through stuff
	{
		Other = Trace(HitLocation, HitNormal, End, Start, true, , HitMaterial);

		bTraceWater=false;

        //Log("GetPenetrationDamageScale: Trace: Dist: "$dist$" pwr: "$pwr$" reducing by: "$VSize(HitLocation - Start));

		dist -= VSize(HitLocation - Start);
        pwr -= VSize(HitLocation - Start);

		if (Other == None)
		{
			LastHitLoc = End;
			break;
		}

		// Water
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		{
			Start = HitLocation;
			End = Start + X * Dist;
			bTraceWater=false;
			continue;
		}

		LastHitLoc = HitLocation;
			
		if (Other.bWorldGeometry || Mover(Other) != None)
		{
			WallCount++;

			if (
                    WallPenForce > 0 && 
                    WallCount < 5 && 
                    class'WallPenetrationUtil'.static.GoThroughWall
                    (
                        Self, Instigator, 
                        HitLocation, HitNormal, 
                        WallPenForce * SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial)), 
                        X, Start, 
                        ExitNormal, ExitMaterial
                    )
                )
			{

                WallPenDelta = VSize(Start - HitLocation) / SurfaceScale(class'WallPenetrationUtil'.static.GetSurfaceType(Other, HitMaterial));
				WallPenForce -= WallPenDelta;

                //Log("GetPenetrationDamageScale: Wall Pen: pwr: "$pwr$", WallPenDelta: "$WallPenDelta);

                dist -= VSize(Start - HitLocation);

                pwr -= DamageRadius * (WallPenDelta / WallPenetrationForce);

                //Log("GetPenetrationDamageScale: Post Wall Pen: pwr: "$pwr);

				bTraceWater=true;
				continue;
			}

            else 
                pwr = 0;

			break;
		}

		// Still in the same guy
		if (Other == Instigator || Other == LastOther)
		{
			Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
			End = Start + X * Dist;
			bTraceWater=true;
			continue;
		}
		break;
	}

    //Log("GetPenetrationDamageScale: pwr: "$pwr$" DamageRadius: "$DamageRadius);

    return FMax(0f, pwr / DamageRadius);
}

defaultproperties
{
	bNetInitialRotation=True
	bApplyParams=True
    bLimitMomentumZ=True
    RadiusFallOffType=RFO_Quadratic
    bRandomStartRotation=True
    bTearOnExplode=True
    NetTrappedDelay=0.150000

	// backup values in case of failure to assign
    HeadMult=2.0f
    LimbMult=0.75f
	
    ShakeRadius=-1.000000
    bWarnEnemy=True
    MotionBlurRadius=-1.000000
    MotionBlurFactor=4.000000
    MotionBlurTime=5.000000
    ShakeRotMag=(X=256.000000,Y=256.000000,Z=256.000000)
    ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
    ShakeRotTime=6.000000
    ShakeOffsetMag=(X=10.000000,Y=10.000000,Z=20.000000)
    ShakeOffsetRate=(X=200.000000,Y=200.000000,Z=200.000000)
    ShakeOffsetTime=6.000000
    MaxSpeed=0.000000
    DamageRadius=0.000000
    DrawType=DT_StaticMesh
}
