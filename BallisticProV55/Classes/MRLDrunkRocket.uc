//=============================================================================
// MRLRocket.
//
// A Crazy, unpredictable and not too powerful small 'drunk' rocket. They move
// fast and unpredictably, but usually come with lots of others.
//
// Drunkness:
// -Initial low accuracy
// -Duds
// -Strafing
// -Sidewinders
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLDrunkRocket extends BallisticProjectile;

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


simulated event PostBeginPlay()
{
	local Rotator R;

	if (DudChance > FRand())
//	if (FRand() > 0.95)
	{
		bCrazy = true;

		AccelSpeed = 500 + Rand(1000);
		Speed += Rand(500);
//		Speed = 500 + Rand(500);
		MaxSpeed = 1000 + Rand(2000);

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

defaultproperties
{
    WeaponClass=Class'BallisticProV55.MRocketLauncher'
     RollRange=192000
     ScrewRadius=3.000000
     DudChance=-1.000000
     SideWinderChance=0.500000
     MaxStrafeSpeed=32.000000
     ImpactManager=Class'BallisticProV55.IM_MRLRocket'
     AccelSpeed=500.000000
     TrailClass=Class'BallisticProV55.MRLTrailEmitter_C'
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BallisticProV55.DT_MRLRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=1000.000000
     MaxSpeed=5000.000000
     Damage=30.000000
     DamageRadius=96.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BallisticProV55.DT_MRL'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
     AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
     DrawScale=0.500000
     SoundVolume=64
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}
