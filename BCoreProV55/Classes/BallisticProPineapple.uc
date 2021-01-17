//=============================================================================
// BallisticPineapple.
//
// Non-Karma version for use on servers. Currently only derived from by the Pro version of the 
// NRP grenade, hence the name.
//
// Azarael
//=============================================================================
class BallisticProPineapple extends BallisticGrenade
	abstract;

var() int	FireModeNum;		// Da fire mode that spawned dis grenade
var float NewDetonateDelay;
var bool bPineappleInitialized;

replication
{
	reliable if (Role==ROLE_Authority)
		NewDetonateDelay;
}

simulated event Timer()
{
	if (Role < ROLE_Authority && (NewDetonateDelay == default.NewDetonateDelay))
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

    HitActor = None;
/*
	if (HitActor != None)
	{
		if ( Instigator == None || Instigator.Controller == None )
			HitActor.SetDelayedDamageInstigatorController( InstigatorController );
		class'BallisticDamageType'.static.GenericHurt (HitActor, Damage, Instigator, Location, MomentumTransfer * (HitActor.Location - Location), MyDamageType);
	}
*/

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
		Velocity = vect(0,0,0);
		SetCollision(false,false,false);
		TearOffHitNormal = HitNormal;
		bTearOff = true;
		GoToState('NetTrapped');
	}
	
	else Destroy();
}

simulated function bool CanTouch(Actor Other)
{
    if (!Super.CanTouch(Other))
        return false;

    return (!bHasImpacted || Pawn(Other) == None);
}

simulated event PostBeginPlay()
{
	local Rotator R;
	
	Super.PostBeginPlay();
	R = Rotation;
	R.Roll = -8192;
	SetRotation(R);
}

function InitProPineapple(float PSpeed, float PDelay)
{
	PDelay = FMax(PDelay, 0.1);
	
	Speed = PSpeed;

	DetonateDelay = PDelay;
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

	if (NewDetonateDelay != default.NewDetonateDelay && DetonateDelay != NewDetonateDelay)
		DetonateDelay = NewDetonateDelay;
		
	if (!bPineappleInitialized && NewDetonateDelay != default.NewDetonateDelay)
	{
		if (StartDelay == 0)
			InitProjectile();
	}

}

simulated event PostNetBeginPlay()
{
	if (DetonateDelay <= StartDelay)
		StartDelay = DetonateDelay / 2;
	DetonateDelay -= StartDelay;
	super.PostNetBeginPlay();
}

defaultproperties
{
     NewDetonateDelay=-0.120000
     bNoInitialSpin=True
     bRandomStartRotaion=False
     StartDelay=0.300000
     NetTrappedDelay=1.000000
     bNetTemporary=False
     bUpdateSimulatedPosition=True
     LifeSpan=6.000000
     DrawScale=0.200000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bUseCylinderCollision=False
     bNetNotify=True
     RotationRate=(Roll=0)
}
