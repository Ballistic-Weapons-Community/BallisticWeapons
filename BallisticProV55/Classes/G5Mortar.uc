//=============================================================================
// G5Mortar.
//
// Big fancy mortar-like heat seeking rocket. First, its given a target by
// player's aim, then it starts by going up as high as possible before coming
// back down and going after the target. Should work best at long range and
// when there is a high ceiling.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G5Mortar extends G5Rocket;

var   actor		Target;				// The actor we are trying to annihilate
var   vector	LastLoc;			// Place where target was last seen
var   vector	Peak;				// The peak of the rocket's journey (it goes up here before coming down on the target)
var   bool		bPeaking;			// Still heading up
var   bool		bTrailOff;			// Is trail currently stopped
var	  bool		bFlyOff;			// Stop tracking and just keep going in whatever direction it's already going
var() float		TurnRate;			// Rate of rotation towards target. Rotator units per seconds.
var() bool		bDamaged;			// Has been damaged and is awaiting to explode
var   G5MortarDamageHull DamageHull;// Da collidey fing spawned to get damaged to blow dis rocket up

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		Target, LastLoc, bFlyOff;
}

function SetMortarTarget(Actor Targ)
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
	InitMortar();
}

// This sets the peak up to 5000 units above the mid point between the target and
// us depending on
simulated function InitProjectile()
{
	Super.InitProjectile();

	if (Role < ROLE_Authority)
		InitMortar();
}
simulated event Destroyed()
{
	if (DamageHull != None)
		DamageHull.Destroy();
	super.Destroyed();
}
simulated function InitMortar()
{
	local vector HitLoc, HitNorm, Start, End, Mid;
	local actor T;
	local int i;
	local float Height;

	Acceleration = vect(0,0,0);
	Peak = Location;

	Height = 3000;
	if (Target != None)
		Speed *= 0.35;
		MaxSpeed *= 0.35;
	if (ONSTreadCraft(Target)!=None || ONSWheeledCraft(Target)!=None)	{
		Height = 2000;	}
	else if (ONSHoverCraft(Target)!=None)	{
		TurnRate *= 1.25;
		MaxSpeed *= 3;	}

	Start = Location + Vector(Rotation) * Speed * 0.2;
	Mid = Location + (LastLoc - Location) * 0.5;
	End = Mid + Vect(0,0,1)*Height;
	// Find the ceiling
	T = Trace(HitLoc, HitNorm, End, start, true);
	if (T == None)
	{
		HitLoc = End;
		HitNorm = vect(0,0,-1);
	}
	else if (HitLoc.Z - Mid.Z < Height)
		Height = (HitLoc.Z - Mid.Z) - 50;
	// Now check if we can reach the target starting at the maximum height or descend until we can
	for (i=0;i<10;i++)
	{
		if (FastTrace(LastLoc, HitLoc))
		{	// Peak found
			Peak = HitLoc - HitNorm * Speed * 0.1;
			bPeaking=true;
			break;
		}
		Height *= 0.7;	// Try lower
		HitLoc = Mid + Vect(0,0,1) * Height;
	}
	Velocity = Normal(LastLoc - Location) * Speed;
	if (Role == ROLE_Authority && DamageHull == None)
	{
		DamageHull = Spawn(class'G5MortarDamageHull',Instigator,,location,Rotation);
		DamageHull.SetBase(Self);
//		DamageHull.SetOwner(Instigator);
	}
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

	if (Speed > MaxSpeed / 2)
		bCanHitOwner=true;

	// Keep checking on the target
	if (Role == ROLE_Authority)
	{
		if (Target != None)
		{
			if(FastTrace(Location, Target.Location))
			{
				LastLoc = Target.Location;
				bFlyOff=False;
			}
			else bFlyOff = True; //break seek while target is out of sight
		}
	}
	// Guid the projectile
	if (!bFlyOff)
	{
		if (bPeaking)	// Head for the peak
			V = Peak - Location;
		else			// Head for the target
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

		// If it's reached the peak, it can now go down
		if (bPeaking && VSize(V) < Speed * 1.2 * (( acos( Normal(Velocity) dot Normal(LastLoc - Peak) ) * (32768/Pi) ) / TurnRate))
			bPeaking = false;
		// If the target is gone and we've reached the last location, just fly off in a straight line
		else if (!bPeaking && Target == None && VSize(V) < Speed * 0.1)
			bFlyOff = true;
	}
	R = Rotation;
	R = Rotator(Velocity);
	R.Roll = Rotation.Roll;
	SetRotation(R);
}

// Got hit, explode immediately - improved proj code handles this
event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<BallisticDamageType>(DamageType) != None && !class<BallisticDamageType>(DamageType).default.bDetonatesBombs)
		return;
	if (Damage < 5)
		return;
	Explode(Location, Normal(Velocity));
}

simulated function bool CanTouch(Actor Other)
{
    if (G5MortarDamageHull(Other) != None && (Other == DamageHull || DamageHull == None))
		return false;

    return Super.CanTouch(Other);
}

simulated function ApplyImpactEffect(Actor Other, vector HitLocation)
{
    if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

    if (!bArmed)
        class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, ImpactMomentumTransfer * Normal(Velocity), ImpactDamageType);
    else 
        class'BallisticDamageType'.static.GenericHurt (Other, Damage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity),MyDamageType);
}

simulated function bool Impact(Actor Other, vector HitLocation)
{
    if (bArmed)
        return false;

    Destroy();
    return true;
}

simulated singular function HitWall(vector HitNormal, actor Wall)
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
	MakeNoise(1.0);

	Explode(Location + ExploWallOut * HitNormal, HitNormal);
	HurtWall = None;
}

defaultproperties
{
     TurnRate=49152.000000
     AccelSpeed=750.000000
     MyRadiusDamageType=Class'BallisticProV55.DTG5MortarRadius'
     Speed=3500.000000
     MaxSpeed=5000.000000
     DamageRadius=378.000000
     MyDamageType=Class'BallisticProV55.DTG5Mortar'
     LifeSpan=0.000000
     bFullVolume=True
     bNetNotify=True
}
