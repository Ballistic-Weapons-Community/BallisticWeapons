//=============================================================================
// G5SeekerRocket.
//
// A G5 rocket that can be guided to a given point
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class G5SeekerRocket extends G5Rocket;

var   vector	LastLoc;			// Place where target was last seen
var() float		TurnRate;			// Rate of rotation towards target. Rotator units per seconds.
var() bool		bSeeking;			// Seeking mode on. Trying to get to our target point
var 	bool		bHasImpacted;	//Hit a wall. Stop seeking, because rocket has either exploded or ricocheted
var   G5MortarDamageHull DamageHull;// Da collidey fing spawned to get damaged to blow dis rocket up

replication
{
	reliable if (Role == ROLE_Authority)
		LastLoc, bSeeking;
}

// WallPenetrationUtil will conflict with this change causing a crash. "it's rare to be able to get unrealscript to foul up that badly"
/*simulated function InitProjectile ()
{
	super.InitProjectile();
	if (Role == ROLE_Authority && DamageHull == None)
	{
		DamageHull = Spawn(class'G5MortarDamageHull',Instigator,,location,Rotation);
		DamageHull.SetBase(Self);
	}
}*/

// Got hit, explode with a tiny delay
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (Damage < 5)
		return;

	Explode(Location, Normal(Velocity));
}

simulated function bool CanTouch (Actor Other)
{
	if (G5MortarDamageHull(Other) != None && (Other == DamageHull || DamageHull == None))
		return false;
	return super.CanTouch(Other);
}

function HitWall(vector HitNormal, actor Wall)
{
	if (G5MortarDamageHull(Wall) != None && (Wall == DamageHull || DamageHull == None))
		return;

	if ( !Wall.bStatic && !Wall.bWorldGeometry )
	{
		if ( Instigator == None || Instigator.Controller == None )
			Wall.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (Wall, Damage, Instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
		if (DamageRadius > 0 && Vehicle(Wall) != None && Vehicle(Wall).Health > 0)
			Vehicle(Wall).DriverRadiusDamage(Damage, DamageRadius, InstigatorController, MyDamageType, MomentumTransfer, Location);
		HurtWall = Wall;
	}
	
	if(!bArmed)
	{	
		if ( !Level.bDropDetail && (FRand() < 0.4) )
			Playsound(ImpactSounds[Rand(6)]);
		Velocity = 0.45 * (Velocity - 1.33*HitNormal*(Velocity dot HitNormal)); //reflection is not complete
		SetRotation(Rotator(Velocity));
		AccelSpeed *= 0.75;
		Acceleration = AccelSpeed * Normal(Velocity);
		bHasImpacted=True;
		bSeeking=False;
		MakeNoise(1.0);
		return;
   	}
   	
	MakeNoise(1.0);

	Damage *= 1 + FClamp(default.LifeSpan  - (LifeSpan + ArmingDelay), 0, 0.5);
	Explode(Location + ExploWallOut * HitNormal, HitNormal);
	HurtWall = None;
}

simulated event Destroyed()
{
	if (DamageHull != None)
		DamageHull.Destroy();
	super.Destroyed();
}

function SetTargetLocation(vector Loc)
{
	if(bHasImpacted)
		return;
		
	LastLoc = Loc;
	bSeeking = true;
}

simulated function Tick(float DT)
{
	local Vector V, X,Y,Z;
	local Rotator R, AxisDir;
	local float TurnNeeded;

	if (bExploded)
		Destroy();

	if (Speed < MaxSpeed)
		Speed = FMin(MaxSpeed, Speed + AccelSpeed * DT);

	// Guide the projectile
	if (bSeeking)
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
	R = Rotation;
	R = Rotator(Velocity);
	R.Roll = Rotation.Roll;
	SetRotation(R);
}

defaultproperties
{
     TurnRate=20000.000000
     ImpactDamage=45.000000
     AccelSpeed=2500.000000
     Speed=500.000000
     MaxSpeed=6500.000000
     LifeSpan=0.000000
}
