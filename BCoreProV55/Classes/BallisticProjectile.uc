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
	config(BallisticProV55);

var() class<BCImpactManager>ImpactManager;			// Impact manager to spawn on final hit
var() class<BCImpactManager>PenetrateManager;		// Impact manager to spawn when going through actors
var() bool					bCheckHitSurface;		// Check impact surfacetype on explode for surface dependant ImpactManagers
var() bool					bPenetrate;				// Will go through enemies
var() bool					bRandomStartRotaion;	// Set random roll on startup
var() float					AccelSpeed;				// Acceleration speed
var() float					StartDelay;				// Used to delay projectile's entry into the world
var() class<Actor>			TrailClass;				// Actor to use for trail
var	  Actor					Trail;					// The trail Actor
var() Vector				TrailOffset;			// Offset from location at which to spawn trail
var() class<DamageType>		MyRadiusDamageType;		// DamageType to use for splash damage
var   actor					HitActor;				// Actor that got hit directly
var   bool					bCanHitOwner;			// Bounced or turned around or something so it can hit owner
var   bool					bExploded;				// Already Blown up. Used by troublesome rocekts that keep going off on clients
var() bool					bTearOnExplode;			// If !bNetTemporary, tear this projectile off when it explodes
var() float					NetTrappedDelay;		// How long to remain in nettrapped state before being destroyed
var() bool					bUsePositionalDamage;	// Enable damage variation depending on hitlocation

var() float					HeadMult;		        // Multiplier for effect against head
var() float					LimbMult;		        // Multiplier for effect against limb

var() class<DamageType>		DamageTypeHead;			// Damagetype for headshots
var() class<DamageType>		DamageTypeLimb;			// Damagetype for limbshots

var() class<BCImpactManager>SplashManager;			// Impact manager to spawn for splashes
var() float	 				ShakeRadius;			// Shake the view of players withing this radius when Exploding
var() bool					bWarnEnemy;				// Warn enemies that it's coming for em
var() float					MotionBlurRadius;
var() float					MotionBlurFactor;
var() float					MotionBlurTime;

var() bool					bCoverPenetrator;
// camera shakes //
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view

var Vector TearOffHitNormal;

replication
{
	reliable if (bTearOff && Role == ROLE_Authority)
		TearOffHitNormal;
}

simulated event TornOff()
{
	Explode(Location, TearOffHitNormal);
}

//LinkGun version
simulated function PostBeginPlay()
{
    local Rotator R;
    
    Super(Projectile).PostBeginPlay();

	Velocity = Vector(Rotation);
	Velocity *= Speed;

	if(bRandomStartRotaion) //lol
	{
		R = Rotation;
		R.Roll = Rand(65536);
		SetRotation(R);
	}
}

//Modified LinkGun
simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = Normal(Velocity) * AccelSpeed;

	if (StartDelay > 0)
	{
		if(Role == ROLE_Authority || bNetOwner || bAlwaysRelevant)
		{
			SetPhysics(PHYS_None);
			bHidden=true;
			SetTimer(StartDelay, false);
			bDynamicLight=false;
			return;
		}
		
		else StartDelay = 0;
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

// Initialize projectile stuff. This will be delayed by StartDelay
simulated function InitProjectile ()
{
	InitEffects();
}

// When start delay ends, set all the properties that make it visible
simulated function Timer()
{
	if (StartDelay > 0)
	{
		StartDelay = 0;
		SetPhysics(default.Physics);
		bDynamicLight=default.bDynamicLight;
		bHidden=false;
		InitProjectile();
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

// Returns the amount by which MaxWallSize should be scaled for each surface type. Override in subclasses to change...
function float SurfaceScale (int Surf, out byte bHard) //hurp durp you can't have an out bool.
{
	switch (Surf)
	{
		Case 0:/*EST_Default*/	bHard = 1; return 0.5;
		Case 1:/*EST_Rock*/		bHard = 1; return 0.5;
		Case 2:/*EST_Dirt*/			return 0.35;
		Case 3:/*EST_Metal*/		bHard = 1; return 0.25;
		Case 4:/*EST_Wood*/		return 0.55;
		Case 5:/*EST_Plant*/		return 0.5;
		Case 6:/*EST_Flesh*/		return 1;
		Case 7:/*EST_Ice*/			bHard=1;return 0.75;
		Case 8:/*EST_Snow*/		return 1;
		Case 9:/*EST_Water*/		return 1;
		Case 10:/*EST_Glass*/		return 1;
		default:								bHard = 1; return 0.5;
	}
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
	
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

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	// Do damage for direct hits
	if (Role == ROLE_Authority && HitActor != Other)		
		DoDamage(Other, HitLocation);
		
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		HitActor = Other;
		X = Normal(Velocity);
		SetLocation(HitLocation + (X * (Other.CollisionHeight*2*X.Z + Other.CollisionRadius*2*(1-X.Z)) * 1.2));
	    if ( EffectIsRelevant(Location,false) && PenetrateManager != None)
			PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, Other.SurfaceType, Owner, 4/*HF_NoDecals*/);
	}
	else if (Role == ROLE_Authority)
	{	
		// Spawn projectile death effects and try radius damage

		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
	local PlayerController PC;

	if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && (!Wall.bWorldGeometry || Wall.bCanBeDamaged) )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			Wall.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
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

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
    local Vector ClosestLocation, BoneTestLocation, temp;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (xPawn(Other) != None)
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the hit along the projectile's Velocity to a point where it is closest to the victim's Z axis.
		temp = Normal(Velocity);
		temp *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation = temp;
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(temp);
		BoneTestLocation += HitLocation;
		
		class'BallisticDamageType'.static.GenericHurt (GetDamageVictim(Other, BoneTestLocation, Normal(Velocity), Dmg, DT), Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);
	}
	else class'BallisticDamageType'.static.GenericHurt (GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT), Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);
}

simulated function bool CanPenetrate(Actor Other)
{
	if (!bPenetrate || Other == None || Other.bWorldGeometry || Mover(Other) != None || Vehicle(Other) != None || DestroyableObjective(Other) != None)
		return false;
	return true;
}
simulated function Actor GetDamageVictim (Actor Other, vector HitLocation, vector Dir, out float Dmg, optional out class<DamageType> DT)
{
	local string	Bone;
	local float		BoneDist;
	local Vector 	HitLocationMatchZ;
	local Pawn		DriverPawn;

	Dmg = Damage;
	DT = MyDamageType;

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
			Bone = string(Other.GetClosestBone(HitLocation, Dir, BoneDist, 'head', 10));
			if (InStr(Bone, "head") > -1)
			{
				Dmg *= HeadMult;

				if (DamageTypeHead != None)
					DT = DamageTypeHead;
			}
			
			// Limb shots
			else if (HitLocation.Z < Other.Location.Z - (Other.CollisionHeight/6) || VSize(HitLocationMatchZ - Other.Location) > 22) //accounting for groin region here
			{
				Dmg *= LimbMult;

				if (DamageTypeLimb != None)
					DT = DamageTypeLimb;
			}
		}
	}

	return Other;
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
			//Cover penetration code for explosives.
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
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/ (DamageRadius * DmgRadiusScale));
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

function float GetCoverReductionFor(vector TargetLoc)
{
	local Vector HitLocation, HitLocationTwo, HitNormal;
	local Material HitMat;
	local float MatScale, Dist;
	local byte bHard;
	
	Trace(HitLocation, HitNormal, TargetLoc, Location, false, , HitMat);
	
	Trace(HitLocationTwo, HitNormal, Location, TargetLoc, false);
	
	if (HitMat != None)
		MatScale = SurfaceScale(int(HitMat.SurfaceType), bHard);
	else MatScale = 1;
	
	Dist = VSize(HitLocation - HitLocationTwo);
	
	if (bHard == 0)
		return Dist / MatScale;
	else if (Dist / MatScale > DamageRadius)
		return 0;
	return 1;
}

defaultproperties
{
     bRandomStartRotaion=True
     bTearOnExplode=True
     NetTrappedDelay=0.150000
     HeadMult=1.500000
     LimbMult=0.700000
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
