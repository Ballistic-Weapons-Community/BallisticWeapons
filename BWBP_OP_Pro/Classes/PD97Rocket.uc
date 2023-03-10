//=============================================================================
// PD97Rocket.
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
class PD97Rocket extends BallisticProjectile;

//var   float		FuelOutTime;
var   actor		Target;				// The actor we are trying to anihilate
var   vector	LastLoc;			// Place where target was last seen, used to guide the rocket
var() float		TurnRate;			// Rate of rotation towards target. Rotator units per seconds.
var() bool		bSeeking;			// Seeking mode on. Trying to get to our target point
var() float		LastSendTargetTime; // Time when a target location has been set, used for difference formula

var		vector		StrafeVelocity;
var		float		StrafeEndTime;

var     bool		bSideWinder;
var     int			RollRange;
var     float		ScrewRadius;

var     bool		bCrazy;

var()	float		DudChance;
var()	float		SideWinderChance;
var()	float		MaxStrafeSpeed;

var() PD97Bloodhound  Master;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		Target, LastLoc, bSeeking, SetRocketDestination, SetRocketTarget;
	reliable if (bNetOwner && Role < ROLE_Authority)
		ServerNotifyReceived;

}

//===========================================================================
// Tracking Code
//===========================================================================
function SetRocketTarget(Actor Targ)
{
	local vector HitLoc, HitNorm, Start, End;
	local Actor T;

	Target = Targ;
	if (Target != None)
		LastLoc = Target.Location;
	else
	{
 		Start = Instigator.Location + Instigator.EyePosition();
		End = Start + Vector(Instigator.GetViewRotation()) * 20000;
		T = Instigator.Trace(HitLoc, HitNorm, End, Start, true);
		if (T != None)
			LastLoc = HitLoc;
		else
			LastLoc = End;
	}
}

function SetRocketDestination()
{
	if (Master != None && Master.bLockedOn)
	{
		bSeeking = true;
		LastLoc = Master.GetRocketTarget();
	}
}


//===========================================================================
// Drunk rocket code
//===========================================================================

simulated event PostBeginPlay()
{
	local Rotator R;

	if (DudChance > FRand())
	{
		bCrazy = true;

		AccelSpeed = 500 + Rand(1000);
		Speed += Rand(500);
		MaxSpeed = 1000 + Rand(2000);

		RotationRate.Pitch = RollRange*(FRand()*2-1.0);
		RotationRate.Yaw = RollRange*(FRand()*2-1.0);
		RotationRate.Roll = RollRange*(FRand()*2-1.0);

		R.Yaw   = -4000 + Rand(8000);
		R.Pitch = -4000 + Rand(8000);
		SetRotation(R+Rotation);

		bSideWinder = true;
		ScrewRadius = ScrewRadius*4 + Rand(ScrewRadius*24);
	}
	else if (!bSeeking)
	{
		RotationRate.Roll = RollRange*(FRand()*2-1.0);
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

	if (Instigator.IsLocallyControlled())
		ServerNotifyReceived();
		
	GetAxes(Rotation, X,Y,Z);
	StrafeVelocity = Y * (FRand()*2-1)*MaxStrafeSpeed;
	Velocity += StrafeVelocity;
	StrafeEndTime = level.TimeSeconds + FRand()*0.5;
	if (bCrazy)
		Velocity += vect(0,0,300);
}

function ServerNotifyReceived()
{
//	if (Role == ROLE_Authority && PD97Bloodhound(Owner) != None)
//		PD97Bloodhound(Owner).AddProjectile(self);
}

simulated event Tick(float DT)
{
	local vector V, X,Y,Z, ScrewCenter;
	local Rotator R, AxisDir;
	local float TurnNeeded;
	
	// Query the master weapon for a target lock
	if (Role == ROLE_Authority && level.TimeSeconds - LastSendTargetTime > 0.04)
	{
		LastSendTargetTime = level.TimeSeconds;
		SetRocketDestination();
	}
	
	if (!bSeeking) //go crazy, ye untamed rockets
	{
		if (bCrazy)
		{
			Acceleration = vsize(Acceleration) * vector(Rotation);
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
		else if (StrafeEndTime != 0 && level.TimeSeconds >= StrafeEndTime )
		{
			StrafeEndTime = 0;
			Velocity -=	StrafeVelocity;

			AccelSpeed += 3000;
			Acceleration = Vector(Rotation) * AccelSpeed;

		}
	}
	else 	// Guide the projectile if the previous call returned a valid lock
	{
		V = LastLoc - Location;

		// Align velocity towards target, but limit how fast rocket can turn. Use a tricky units per second rate limit.
		X = Normal(Velocity);
		Y = Normal(V cross Velocity);
		Z = Normal(X cross Y);
		AxisDir = OrthoRotation(X,Y,Z);

		TurnNeeded = acos(Normal(V) Dot Normal(Velocity)) * (32768 / Pi);

		R.Pitch = FMin( TurnRate*DT, TurnNeeded );
		GetAxes(R,X,Y,Z);
		X = X >> AxisDir;
		Y = Y >> AxisDir;
		Z = Z >> AxisDir;
        R = OrthoRotation(X,Y,Z);
		Velocity = Normal(Vector(R)) * Speed;

		if (Normal(Velocity) Dot Normal (V) > 0.6 && VSize(V) < Speed * 0.1)
			bSeeking = false;
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
    WeaponClass=Class'BWBP_OP_Pro.PD97Bloodhound'
     TurnRate=32768.000000
     RollRange=192000
     ScrewRadius=3.000000
     DudChance=0.020000
     SideWinderChance=0.050000
     MaxStrafeSpeed=32.000000
     //bRandomStartRotaion=False
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
     ImpactManager=Class'BallisticProV55.IM_MRLRocket'
     TrailClass=Class'BallisticProV55.MRLTrailEmitter'
     TrailOffset=(X=-4.000000)
     MyDamageType=Class'BWBP_OP_Pro.DT_PD97Rocket'
     MyRadiusDamageType=Class'BWBP_OP_Pro.DT_PD97RocketRadius'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
     AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
     SoundVolume=64
	 bTearOff=False
	 bNetTemporary=False
	 bUpdateSimulatedPosition=True
}
