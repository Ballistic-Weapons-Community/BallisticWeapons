//=============================================================================
// FP9Bomb.
//
// This is the versatile FP9A5 Bomb projectile. It sticks to walls, has a laser
// detonator, can be remote detonated, blows up when damaged, can taken back by
// its owner and can be thrown if not deployed on a wall.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP9Bomb extends BallisticKGrenade;

var   bool				bLaserMode;		// This bomb will use the laser detonator
var   bool				bNetLaserOn;	// This bomb will use the laser detonator
var   bool				bDeployed;		// It is stuck on a wall, not thrown
var   bool				bDetonate;		// Flaged for detonation next tick. Sent to net clients when detonated on server
var   bool				bDetonated;		// Blown up, no more blowing up.
var() class<Actor>		RedLaserClass, BlueLaserClass;		// Class of laser beam actor
var   Actor				Laser;			// The laser actor
var() class<damageType>	LaserDamageType;// Damagetype to use when detonated by laser
var() class<damageType>	ShotDamageType;	// Damagetype to use when detonated by damage
var   FP9Trigger		MyUseTrigger;	// The trigger that sends use events
var   float				ThrowTime;		// How long fire was held for throw range
var() bool				bDamaged;		// Has been damaged and is about to blow
var() int				Health;			// Distance from death
var   bool				bLaserDetonated;// Someone stepped into the beam. This tells it which damagetype to use
var() Sound				LaserOnSound;	// Sound when laser goes on
var() Sound				LaserOffSound;	// Sound when laser goes off
var() float				OldLaserRange;	// Range of laser last tick
var() Material			LaserSkin;		// Skin to put on bomb screen when in laser mode
var   Vector			NetLocation;	// Location replicated when needed
var   Rotator			NetRotation;	// Rotation replicated when needed
var   bool				bStopMoving;	// Replicated to tell simulated bomb to stop moving
var   Rotator			laserDir;		// Dierction laser is pointed
var() float				BombDetonateDelay;	// Delay before you can detonate the bomb after throwing or placing it.
var   float				DetonateTime;	// Time when the bomb is first allowed to be detonated.
var   int					Team;
var   bool				bAntiLameMode; // If this bomb is triggered, the placer will be killed.
var	Pawn				TriggeringPawn, OriginalPlacer;

replication
{
	reliable if (Role == ROLE_Authority)
		bNetLaserOn, bDeployed, ThrowTime, LaserDir, Team;
	unreliable if (Role == ROLE_Authority)
		NetLocation, NetRotation, bStopMoving;
}

// Set up bomb with settings from WeaponFire
function InitBomb(bool bThrown, bool bLaserOn, float HoldTime)
{
	local Actor TA;
	local Teleporter TB;
	
	bDeployed = !bThrown;
	if (bDeployed)
	{
		bCollideWorld = false;
		KSetBlockKarma(False);
		SetPhysics(PHYS_None);
	}
	bLaserMode = bLaserOn;
	if (Role == ROLE_Authority)
	{
		MyUseTrigger = Spawn(class'FP9Trigger',self ,, Location);
		MyUsetrigger.SetBase(self);
		OriginalPlacer = Instigator;
	}
	
	ThrowTime = HoldTime;
	
	//Check for shit.
	foreach TouchingActors(class'Actor', TA)
	{
		if (xPickUpBase(TA) != None || Pickup(TA) != None)
			bAntiLameMode = True;
			return;
	}
	
	//No teleporter camping, die die die
	foreach RadiusActors(class'Teleporter', TB, DamageRadius)
	{
			bAntiLameMode=True;
			return;
	}
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
		
	// Reverse damage if I was used to lame
	if(bAntiLameMode && OriginalPlacer != None)
	{
		if (TriggeringPawn != None)
			class'BallisticDamageType'.static.GenericHurt(OriginalPlacer, 666, TriggeringPawn, HitLocation, MomentumTransfer * vect(0,0,1), class'DT_TeleportLamer');
		else class'BallisticDamageType'.static.GenericHurt(OriginalPlacer, 666, Instigator, HitLocation, MomentumTransfer * vect(0,0,1), class'DT_TeleportLamer');
	}

	else if (DamageRadius > 0)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	MakeNoise(1.0);
}

simulated function PostBeginPlay ()
{
	Super.PostBeginPlay();

	bCollideWorld = false;
	KSetBlockKarma(False);
	DetonateTime = Level.TimeSeconds+BombDetonateDelay;
	
	if (Level.NetMode != NM_Client && Instigator != None)
	{
		if (Instigator.GetTeamNum() == 255)
			Team = 1;
		else
			Team = Instigator.GetTeamNum();
	}
}

simulated function PostNetBeginPlay ()
{
	Super.PostNetBeginPlay();

	LaserDir = Rotation;
	default.LaserDir = Rotation;
}

// More Init after StartDelay
simulated function InitProjectile ()
{
	InitEffects();

	Speed *= FClamp(ThrowTime-0.3, 0, 1) / 1;
	if (bDeployed && bLaserMode)
		SetTimer(2.0, false);
	else if (!bDeployed)
		super.InitProjectile();
}

simulated event Timer()
{
	local Rotator R;

	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		if (!bDeployed)
		{
			R = Rotation;
			R.Yaw += 32768;
			R.Pitch += 8192;
			SetRotation(R);
			if (level.NetMode == NM_Client)
				SetPhysics(PHYS_Falling);
			else
				SetPhysics(default.Physics);
			bCollideWorld = true;
			KSetBlockKarma(true);
		}
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		return;
	}
	// Laser activate time
	else if (bDeployed && bLaserMode && Laser == None)
	{
		bNetLaserOn=true;
		Skins[2] = LaserSkin;
		PlaySound(LaserOnSound,,1.0,,64);
		
		if (Team == 1)
			Laser = Spawn(BlueLaserClass,self,,Location,LaserDir);
			
		else Laser = Spawn(RedLaserClass,self,,Location,LaserDir);
		
	    Laser.SetBase(self);
	}
}

simulated function Tick(float DT)
{
	local Actor T;
	local Vector HitLoc, HitNorm, V;

	super.Tick(DT);

	if (!bDeployed && Role == ROLE_Authority && StartDelay == 0/*(level.netMode == NM_ListenServer || level.NetMode == NM_DedicatedServer)*/)
	{
		if (Location != NetLocation)
			NetLocation = Location;
		else
		{
			bStopMoving = true;
			bDeployed=true;
			SetTimer(2.0, false);
			LaserDir = Rotation;
		}
		if (Rotation != NetRotation)
			NetRotation = Rotation;
	}

	if ((bNetLaserOn && Laser==None) || (!bNetLaserOn && Laser!=None))
		AdjustLaser();

	if (!bNetLaserOn || Laser == None)
		return;

	// Check for movement when laser is active
	T = Trace(HitLoc, HitNorm, Location + vector(LaserDir)*5000, Location, true);
    V = Laser.DrawScale3D;
    
	if (T != None)
	{
		if  (Pawn(T) != None && Pawn(T).Controller != None && (InstigatorController == None || !Pawn(T).Controller.SameTeamAs(InstigatorController) || Pawn(T).Controller == InstigatorController))
		{
			if (Role == ROLE_Authority && OldLaserRange != -1 && Abs(VSize(HitLoc - Location) - OldLaserRange) > 64 * DT)
			{
				TriggeringPawn=Pawn(T);
				bLaserDetonated=true;
				Detonate();
				return;
			}
		}
		OldLaserRange = VSize(HitLoc - Location);
	    V.X = OldLaserRange / 128;
	}
	else
	    V.X = 5000 / 128;
   	Laser.SetDrawScale3D(V);
}


// Don't touch anything when deployed
simulated function bool CanTouch(Actor Other)
{
	if (bDeployed)
		return false;
	return Super.CanTouch(Other);
}

// Call this to make it go BOOM...
function Detonate()
{
	bLaserMode = false;
	bNetLaserOn = false;
	if (bDeployed)
		Explode(Location, Vector(Rotation));
	else
		Explode(Location, vect(0,0,1));
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
	
	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
	{
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else Destroy();
}

simulated event TornOff()
{
	Explode(Location, TearOffHitNormal);
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();

	if (!bDeployed)
	{
		if (bStopMoving)
		{
			SetPhysics(PHYS_None);
			SetLocation(NetLocation);
			SetRotation(NetRotation);
			bDeployed=true;
			SetTimer(2.0, false);
			LaserDir = Rotation;
		}
		if (NetLocation != default.NetLocation)
		{
			default.NetLocation = NetLocation;
			SetPhysics(PHYS_None);
			SetLocation(NetLocation);
			SetPhysics(PHYS_Karma);
		}
		if (NetRotation != default.NetRotation)
		{
			default.NetRotation = NetRotation;
			SetRotation(NetRotation);
		}
	}
	else if (LaserDir != default.LaserDir && Laser != None)
		Laser.SetRotation(LaserDir);
}

function SetLaserDir (Rotator NewDir)
{
	LaserDir = NewDir;
	if (Laser != None)
	
		Laser.SetRotation(LaserDir);
}
// Called from weapon...
function ToggleLaserMode()
{
	bLaserMode = !bLaserMode;
	bNetLaserOn = bLaserMode;
	AdjustLaser();
}

// Show/hide the laser
simulated function AdjustLaser()
{
	if (bDeployed && bNetLaserOn && Laser == None)
	{
		Skins[2] = LaserSkin;
		PlaySound(LaserOnSound,,1.0,,64);
		
		if (Team == 1)
			Laser = Spawn(BlueLaserClass,self,,Location,LaserDir);
			
		else Laser = Spawn(RedLaserClass,self,,Location,LaserDir);
		
	    Laser.SetBase(self);
	}
	else if (!bNetLaserOn && Laser != None)
	{
		OldLaserRange=-1;
		Skins[2] = default.Skins[2];
		PlaySound(LaserOffSound,,1.0,,64);
		Laser.Destroy();
	}
}

simulated function Destroyed()
{
	if (MyUsetrigger != None)
		MyUsetrigger.Destroy();
	if (Laser != None)
		Laser.Destroy();
	super.Destroyed();
}

// Use LaserDamageType when laser detonated
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	if (bLaserDetonated)
		super.TargetedHurtRadius(DamageAmount, DamageRadius, LaserDamageType, Momentum, HitLocation, Victim);
	else
		super.TargetedHurtRadius(DamageAmount, DamageRadius, DamageType, Momentum, HitLocation, Victim);
}

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (bDamaged || DamageType == ImpactDamageType || (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs))
		return;
	Health-=Damage;
	if (Health > 0)
		return;
	bDamaged = true;
	if (EventInstigator != None)
	{
		Instigator = EventInstigator;
		InstigatorController = EventInstigator.Controller;
		MyRadiusDamageType = ShotDamageType;
	}
	Detonate();
}

// Something pressed use on us. Give them the ammo and dissapear.
function TryUse(Pawn User)
{
	local Ammunition Ammo;
	local FP9Explosive Weap;
	local int AmmoAmount;

		Ammo = Ammunition(User.FindInventoryType(class'Ammo_FP9Ammo'));
		if(Ammo == None)
	    {
			Ammo = Spawn(class'Ammo_FP9Ammo');
			User.AddInventory(Ammo);
    	}
    	AmmoAmount = Ammo.AmmoAmount;
    	Ammo.UseAmmo(9999, true);

		Weap = FP9Explosive(User.FindInventoryType(class'FP9Explosive'));
		if (Weap == None)
		{
			Weap = Spawn(class'FP9Explosive', User,,User.Location);
			if (Weap != None)
			{
				Weap.GiveTo(User, None);
				Weap.bHasDetonator = false;
				Weap.ConsumeAmmo(0, 9999, true);
			}
		}
		Ammo.AddAmmo(AmmoAmount + 1);
		Ammo.GotoState('');

		Destroy();
}

defaultproperties
{
     RedLaserClass=Class'BallisticProV55.LaserActor_TripMineRed'
     BlueLaserClass=Class'BallisticProV55.LaserActor_TripMine'
     LaserDamageType=Class'BallisticProV55.DTFP9BombLaser'
     ShotDamageType=Class'BallisticProV55.DTFP9BombShot'
     Health=15
     LaserOnSound=Sound'BW_Core_WeaponSound.FP9A5.FP9-LaserOn'
     LaserOffSound=Sound'BW_Core_WeaponSound.FP9A5.FP9-LaserOff'
     OldLaserRange=-1.000000
     LaserSkin=Shader'BW_Core_WeaponTex.FP9A5.FP9LCDActiveSD'
     BombDetonateDelay=1.500000
     ArmedDetonateOn=DT_None
     DampenFactor=0.500000
     DampenFactorParallel=0.700000
     bNoInitialSpin=True
     ImpactDamage=15
     ImpactDamageType=Class'BallisticProV55.DTFP9Bomb'
     ImpactManager=Class'BallisticProV55.IM_RPG'
     bRandomStartRotation=False
     StartDelay=0.300000
     MyRadiusDamageType=Class'BallisticProV55.DTFP9BombRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     ShakeRadius=1200.000000
     MotionBlurRadius=1024.000000
     WallPenetrationForce=64
     ShakeRotMag=(X=512.000000,Y=400.000000)
     ShakeRotRate=(X=3000.000000,Z=3000.000000)
     ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
     Speed=350.000000
     Damage=150.000000
     DamageRadius=1024.000000
     MomentumTransfer=50000.000000
     MyDamageType=Class'BallisticProV55.DTNRP57Grenade'
     ImpactSound=SoundGroup'BW_Core_WeaponSound.FP9A5.FP9-Bounce'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.FP9.FP9Proj'
     bNetTemporary=False
     bAlwaysRelevant=True
     LifeSpan=0.000000
     DrawScale=0.250000
     Skins(0)=Texture'BW_Core_WeaponTex.FP9A5.FP9Bomb'
     Skins(1)=Texture'BW_Core_WeaponTex.FP9A5.FP9Chain'
     Skins(2)=Shader'BW_Core_WeaponTex.FP9A5.FP9LCDArmedSD'
     bUnlit=False
     CollisionRadius=6.000000
     CollisionHeight=8.000000
     bCollideWorld=False
     bProjTarget=True
     bNetNotify=True
     RotationRate=(Yaw=8192)
}
