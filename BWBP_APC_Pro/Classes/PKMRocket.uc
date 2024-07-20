//=============================================================================
// G5Rocket.
//
// Rocket projectile for the G5 RPG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PKMRocket extends BallisticProjectile;

//var   float		FuelOutTime;

var		vector		StrafeVelocity;
var		float		StrafeEndTime;

var     bool		bSideWinder;
var     int			RollRange;
var     float		ScrewRadius;

var     bool		bCrazy;

var()	float		DudChance;
var()	float		SideWinderChance;
var()	float		MaxStrafeSpeed;

var() int				ImpactDamage;			// Damage when hitting or sticking to players and not detonating
var() Class<DamageType>	ImpactDamageType;		// Type of Damage caused for striking or sticking to players

delegate OnDie(Actor Cam);

simulated function Explode(vector HitLocation, vector HitNormal)
{
	OnDie(self);
	Super.Explode(HitLocation, HitNormal);
}

simulated event PostBeginPlay()
{
	local Rotator R;

	if (DudChance > FRand())
//	if (FRand() > 0.95)
	{
		bCrazy = true;

		AccelSpeed = 6000 + Rand(2000);
		Speed += Rand(1000);
		MaxSpeed = 4000 + Rand(2000);

//		SetPhysics(PHYS_Falling);

//		RotationRate.Pitch = -256000 + Rand(512000);
//		RotationRate.Yaw = -256000 + Rand(512000);
//		RotationRate.Roll = 128000;

		RotationRate.Pitch = RollRange*(FRand()*2-1.0);
		RotationRate.Yaw = RollRange*(FRand()*2-1.0);
		RotationRate.Roll = RollRange*(FRand()*2-1.0);

		R.Yaw   = -4000 + Rand(8000);
		R.Pitch = -4000 + Rand(8000);
		SetRotation(R+Rotation);

		bSideWinder = true;
		ScrewRadius = ScrewRadius*4 + Rand(ScrewRadius*24);
	}
	else
	{
		RotationRate.Roll = RollRange*(FRand()*2-1.0);
//		if (FRand() > 0.3)
		if (SideWinderChance >= FRand())
		{
			bSideWinder = true;
			ScrewRadius += Rand(ScrewRadius*3);
		}
		AccelSpeed += Rand(1000);
		Speed += Rand(500);
		MaxSpeed += Rand(1000);
	}
	SetTimer(1.0 + FRand()*2.0, false);

	super.PostBeginPlay();
}

simulated event PostNetBeginPlay()
{
	local vector X,Y,Z;
	super.PostNetBeginPlay();

	GetAxes(Rotation, X,Y,Z);
//	StrafeVelocity = Y * (Rand(200)-100);
	StrafeVelocity = Y * (FRand()*2-1)*MaxStrafeSpeed;
	Velocity += StrafeVelocity;
	StrafeEndTime = level.TimeSeconds + FRand()*0.5;
	if (bCrazy)
		Velocity += vect(0,0,300);
}

simulated event Tick(float DT)
{
	local vector X,Y,Z, ScrewCenter;
	local Rotator R;

	if (bCrazy)
	{
		Acceleration = vsize(Acceleration) * vector(Rotation);
//		Velocity = vsize(velocity) * vector(rotation);
	}
	if (bSideWinder)
	{
		R = Rotation;
		R.Roll -= RotationRate.Roll * DT;
		GetAxes(R, X, Y, Z);
		ScrewCenter = Location + Y * ScrewRadius;

		GetAxes(Rotation, X, Y, Z);
		SetLocation(ScrewCenter - Y * ScrewRadius);
	}
	else if (StrafeEndTime != 0 && level.TimeSeconds >= StrafeEndTime)
	{
		StrafeEndTime = 0;
		Velocity -=	StrafeVelocity;

		AccelSpeed += 3000;
    	Acceleration = Vector(Rotation) * AccelSpeed;

//    	Speed += 1000;
  //  	Velocity += Vector(Rotation) * Speed;
	}
}

simulated event Timer()
{
	SetPhysics(PHYS_Falling);
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)))
		return;

	if (Role == ROLE_Authority)		// Do damage for direct hits
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
		DoDamage(Other, HitLocation);
	}
	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		HitActor = Other;
		X = Normal(Velocity);
		SetLocation(HitLocation + (X * (Other.CollisionHeight*2*X.Z + Other.CollisionRadius*2*(1-X.Z)) * 1.2));
	    if ( EffectIsRelevant(Location,false) && PenetrateManager != None)
			PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, Other.SurfaceType, Owner, 4/*HF_NoDecals*/);
	}
	else
	{	// Spawn projectile death effects and try radius damage
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

defaultproperties
{
	WeaponClass=Class'BWBP_APC_Pro.PKMMachinegun'
	ModeIndex=1
	RollRange=100000
	ScrewRadius=8.000000
	DudChance=0.030000
	SideWinderChance=1.000000
	MaxStrafeSpeed=8.000000
	ImpactDamage=90
	ImpactDamageType=Class'BWBP_APC_Pro.DTPKM'
	ImpactManager=Class'BWBP_APC_Pro.IM_PKMRocket'
	AccelSpeed=18000.000000
	TrailClass=Class'BWBP_APC_Pro.PKMRocketTrail'
	TrailOffset=(X=-14.000000)
	MyRadiusDamageType=Class'BWBP_APC_Pro.DTE5Plasma'
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	MotionBlurRadius=1024.000000
	ShakeRotMag=(X=512.000000,Y=400.000000)
	ShakeRotRate=(X=3000.000000,Z=3000.000000)
	ShakeOffsetMag=(X=20.000000,Y=30.000000,Z=30.000000)
	Speed=5000.000000
	MaxSpeed=17500.000000
	Damage=30.000000
	DamageRadius=500.000000
	MomentumTransfer=100000.000000
	MyDamageType=Class'BWBP_APC_Pro.DTE5Plasma'
	LightType=LT_Steady
	LightEffect=LE_QuadraticNonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=200.000000
	LightRadius=15.000000
	StaticMesh=StaticMesh'BWBP_CC_Static.PKMA.PKMARocket'
	bDynamicLight=True
	AmbientSound=Sound'BWBP_CC_Sounds.rpk940.RPGFly'
	DrawScale=0.500000
	SoundVolume=192
	SoundRadius=128.000000
	bFixedRotationDir=True
	RotationRate=(Roll=32768)
}
