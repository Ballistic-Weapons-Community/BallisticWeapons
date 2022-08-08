//=============================================================================
// BallisticPineapple.
//
// A Karma based grenade that uses ballistic hand grenade functions like fuse
// timing and velocity variation.
//
// A fancy Karama based grenaded that is thrown high and bounces easily off
// walls. Detonates 4 seconds after clip is released. The pineapple is not too
// effective a weapon in the hands of the amatuer, but once the user masters
// the timing, it will become a very deadly toy. Throw directly at opponents to
// provide them with a nasty concussion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticPineapple extends BallisticKGrenade;

var   float NewDetonateDelay;	// Detonate delay sent to clients
var   float NewSpeed;			// Speed sent to clients
var() int	FireModeNum;		// Da fire mode that spawned dis grenade

var   vector	NetLocation, NetKickForce, LastLocation, LastKickForce;
var   rotator	NetRotation, LastRotation;

var   bool		bPineappleInitialized;

replication
{
	reliable if (Role==ROLE_Authority)
		NewSpeed, NewDetonateDelay;
	unreliable if (Role==ROLE_Authority)
		NetKickForce, NetLocation, NetRotation;
}

simulated event Timer()
{
	if (Role < ROLE_Authority && (NewSpeed == default.NewSpeed || NewDetonateDelay == default.NewDetonateDelay))
	{
		SetTimer(0.1, false);
		return;
	}
	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		return;
	}
	if (HitActor != None)
	{
		if ( Instigator == None || Instigator.Controller == None )
			HitActor.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (HitActor, Damage, Instigator, Location, MomentumTransfer * (HitActor.Location - Location), MyDamageType);
	}
	Explode(Location, vect(0,0,1));
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (ShakeRadius > 0)
		ShakeView(HitLocation);
	BlowUp(HitLocation);
    if (ImpactManager != None)
	{
		if (Instigator == None)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Level.GetLocalPlayerController()/*.Pawn*/);
		else
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 0, Instigator);
	}
	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
	{
		bTearOff = true;
		GotoState('NetTrapped');
	}
	else
		Destroy();
}

simulated event PostBeginPlay ()
{
	local Rotator R;
	
	Super.PostBeginPlay();
	
	R = Rotation;
	R.Roll = -8192;
	SetRotation(R);
}

function InitPineapple(float PSpeed, float PDelay)
{
	PDelay = FMax(PDelay, 0.1);

	Speed = PSpeed;
	DetonateDelay = PDelay;
	NewSpeed = Speed;
	NewDetonateDelay = DetonateDelay;

	if (DetonateDelay <= StartDelay)
		StartDelay = DetonateDelay / 2;
}
simulated function InitProjectile ()
{
	bPineappleInitialized = true;
	Super.InitProjectile();
}
simulated event PostNetReceive()
{
	Super.PostNetReceive();

	if (NewSpeed != default.NewSpeed)
		Speed = NewSpeed;
	if (NewDetonateDelay != default.NewDetonateDelay && DetonateDelay != NewDetonateDelay)
		DetonateDelay = NewDetonateDelay;
	if (!bPineappleInitialized && NewSpeed != default.NewSpeed && NewDetonateDelay != default.NewDetonateDelay)
	{
		if (StartDelay == 0)
			InitProjectile();
	}
	if (NetLocation != LastLocation)
	{
		LastLocation = NetLocation;
		SetPhysics(PHYS_None);
		SetLocation(NetLocation);
		SetPhysics(PHYS_Karma);
	}
	if (NetRotation != LastRotation)
	{
		LastRotation = NetRotation;
		SetRotation(NetRotation);
	}
	if (NetKickForce != LastKickForce)
	{
		LastKickForce = NetKickForce;
		KickPineapple(NetKickForce);
	}
}

simulated event Tick(float DT)
{
	super.Tick(DT);
	if (StartDelay == 0 && (level.netMode == NM_ListenServer || level.NetMode == NM_DedicatedServer))
	{
		if (Location != NetLocation)
			NetLocation = Location;
		if (Rotation != NetRotation)
			NetRotation = Rotation;
	}
}

simulated event PostNetBeginPlay()
{
	if (DetonateDelay <= StartDelay)
		StartDelay = DetonateDelay / 2;
	DetonateDelay -= StartDelay;
	super.PostNetBeginPlay();
}

simulated function KickPineapple(vector Force)
{
	local vector V;
	if (Physics != PHYS_Karma)
		SetPhysics(PHYS_Karma);
	KGetCOMPosition(V);
	KAddImpulse(Force*50, V);
}

function UsedBy(pawn User)
{
	local vector Force;

	Force = Normal((Location - User.Location)*vect(1,1,0)) * (320 + Rand(100));
	Force.Z = 50 + Rand(250);
	Force += User.Velocity;

	NetKickForce = Force;
	KickPineApple(Force);
}

event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> Damagetype, optional int HitIndex)
{
	if (VSize(Momentum) < 2000)
		return;

	NetKickForce = Momentum/75;
	if (Base != None)
		NetKickForce.Z += 250;
	KickPineApple(NetKickForce);
}

simulated event ProcessTouch(actor Other, vector HitLocation)
{
	local vector PineappleDir;
	super.ProcessTouch(Other, HitLocation);

	if (!bDeleteMe && Pawn(Other)!=None && Bot(Pawn(Other).Controller) != None && Pawn(Other).Health > 0)
	{
		PineappleDir = Normal(Location - Other.Location);
 		if (Bot(Pawn(Other).Controller).Skill * ((Vector(Other.Rotation) Dot PineappleDir + 0.4) - PineappleDir.Z*0.4) > Rand(9))
			UsedBy(Pawn(Other));
	}
}

defaultproperties
{
     NewDetonateDelay=-0.120000
     NewSpeed=-0.120000
     DampenFactorParallel=0.800000
     bNoInitialSpin=True
     bRandomStartRotation=False
     StartDelay=0.300000
     NetTrappedDelay=1.000000
     bNetTemporary=False
     LifeSpan=6.000000
     DrawScale=0.200000
     bProjTarget=True
     bNetNotify=True
     RotationRate=(Roll=0)
}
