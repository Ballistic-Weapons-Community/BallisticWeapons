//=============================================================================
// RSDeathBall.
//
// A projectile caused by certain Nova/Darkstar interactions. Tries to go after
// a certain player.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDeathBall extends BallisticProjectile;

var   vector	LastLoc;			// Place where target was last seen
var   Actor		Target;
var() bool		bSeeking;			// Seeking mode on. Trying to get to our target point
var() bool		bDamaged;			// Has been damaged and is awaiting to explode
var() int		Health;
var   float		NextSeekerTime;
var   bool		bIsEvil;
//var   G5MortarDamageHull DamageHull;// Da collidey fing spawned to get damaged to blow dis rocket up

replication
{
	reliable if (Role == ROLE_Authority)
		LastLoc, bSeeking, bDamaged;
}
/*
simulated function InitProjectile ()
{
	super.InitProjectile();
	if (Role == ROLE_Authority && DamageHull == None)
	{
		DamageHull = Spawn(class'G5MortarDamageHull',Instigator,,location,Rotation);
		DamageHull.SetBase(Self);
//		DamageHull.SetOwner(Instigator);
	}
}
*/
simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

    Acceleration = vect(0,0,0);
}

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (Health < 1)
		return;
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (class<DT_RSNovaLightning>(DamageType) != None || class<DT_RSDarkPlasma>(DamageType) != None)
		return;
	Health -= Damage;
//	if (Damage < 5)
//		return;
	if (Health > 0)
		return;
	bDamaged=true;
	SetTimer(0.1, false);
	bTearOff=true;
}

simulated event PostNetReceive()
{
	super.PostNetReceive();
	if (bDamaged && !bExploded)
		Explode(Location, Normal(Velocity));
}

simulated function Timer()
{
	if (bDamaged)
		Explode(Location, Normal(Velocity));
	else if (StartDelay > 0)
		super.Timer();
	else if (Target != None)
	{
		if (FastTrace(Target.Location, Location))
			LastLoc = Target.Location;
	}
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
	local bool bWasAlive;
//	local actor Soul;

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (xPawn(Other) != None && Pawn(Other).Health > 0)
		bWasAlive = true;
	else if (Vehicle(Other) != None && Vehicle(Other).Driver!=None && Vehicle(Other).Driver.Health > 0)
		bWasAlive = true;
	if (bUsePositionalDamage)
		class'BallisticDamageType'.static.GenericHurt (GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT), Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);
	else
		class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), MyDamageType);

	if (bWasAlive && Pawn(Other).Health <= 0)
	{
		if (bIsEvil)
			class'RSDarkSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Other), self);
//			Soul = Spawn(class'RSDarkSoul',,, HitLocation);
		else
			class'RSNovaSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Other), self);
//			Soul = Spawn(class'RSNovaSoul',,, HitLocation);
/*		if (Soul!=None)
		{
			if (RSDarkSoul(Soul) != None)
				RSDarkSoul(Soul).Assailant = Instigator;
			else if (RSNovaSoul(Soul) != None)
				RSNovaSoul(Soul).Assailant = Instigator;
		}
*/	}
}

simulated function bool CanTouch (Actor Other)
{
	if (RSDarkProjectile(Other) != None || RSDarkFastProjectile(Other) != None || RSNovaProjectile(Other) != None || RSNovaFastProjectile(Other) != None)
		return false;

	return super.CanTouch(Other);
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{
//	if (G5MortarDamageHull(Wall) != None && (Wall == DamageHull || DamageHull == None))
//		return;

	if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry )
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			class'BallisticDamageType'.static.GenericHurt (Wall, Damage, Instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
			if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
				Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
	HurtWall = None;
}

/*
simulated event Destroyed()
{
	if (DamageHull != None)
		DamageHull.Destroy();
	super.Destroyed();
}
*/


function SetTarget(Actor T, bool bEvil)
{
	bIsEvil = bEvil;
	if (T != None)
	{
		SetTimer(0.1, true);
		Target = T;
		LastLoc = T.Location;
		bSeeking = true;
	}
}

simulated function Tick(float DT)
{
	local Vector V;
	local Rotator R;

	if (bExploded)
		Destroy();

	if (Speed < MaxSpeed)
		Speed = FMin(MaxSpeed, Speed + AccelSpeed * DT);

	if (Speed > MaxSpeed / 2)
		bCanHitOwner=true;

	Super.Tick(DT);

	// Guid the projectile
	if (bSeeking && level.Timeseconds >= NextSeekerTime)
	{
		V = Normal(LastLoc - Location) * Speed;

		Velocity = Normal(Velocity + V * 0.35) * Speed;

		NextSeekerTime += 0.1;

		if (Normal(Velocity) Dot Normal (V) > 0.6 && VSize(V) < Speed * 0.1)
			bSeeking = false;
	}
	else
		Velocity = Normal(Velocity)*Speed;
	R = Rotation;
	R = Rotator(Velocity);
	R.Roll = Rotation.Roll;
	SetRotation(R);
}

defaultproperties
{
	WeaponClass=Class'BallisticProV55.RSDarkStar'
	bApplyParams=False
	Health=50
	ImpactManager=Class'BallisticProV55.IM_RSDarkProjectile'
	bRandomStartRotation=False
	AccelSpeed=100.000000
	TrailClass=Class'BallisticProV55.RSDeathBallTrail'
	MyRadiusDamageType=Class'BallisticProV55.DT_RSDeathBall'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	ShakeRadius=1024.000000
	MotionBlurRadius=512.000000
	ShakeRotMag=(X=512.000000,Y=400.000000)
	ShakeRotRate=(X=3000.000000,Z=3000.000000)
	ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
	Speed=200.000000
	MaxSpeed=500.000000
	Damage=100.000000
	DamageRadius=128.000000
	MomentumTransfer=90000.000000
	MyDamageType=Class'BallisticProV55.DT_RSDeathBall'
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=200.000000
	LightRadius=15.000000
	DrawType=DT_None
	bDynamicLight=True
	bNetTemporary=False
	bUpdateSimulatedPosition=True
	AmbientSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire1FlyBy'
	LifeSpan=0.000000
	SoundVolume=255
	SoundRadius=75.000000
	bNetNotify=True
}
