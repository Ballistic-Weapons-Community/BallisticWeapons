//=============================================================================
// BallisticPineapple.
//
// Non-Karma version for use on servers. Currently only derived from by the Pro version of the 
// NRP grenade, hence the name.
//
// need to add support for grenades that detonate after hitting the floor
//
// Azarael
//=============================================================================
class BallisticProPineapple extends BallisticGrenade
	abstract;

var() int	FireModeNum;		// Da fire mode that spawned dis grenade
var float   ClientDetonateDelay;
var float   ThrowPower;

replication
{
	reliable if (Role == ROLE_Authority)
		ThrowPower, ClientDetonateDelay;
}

//==================================================================
// PostBeginPlay
//
// Hardcode ThrowPower temporarily
//==================================================================
simulated event PostBeginPlay()
{
    ThrowPower = 1f; // FIXME: Hardcode. Don't have time

	Super.PostBeginPlay();
}

//==================================================================
// SetInitialSpeed
//
// Speed depends on ThrowPower
//==================================================================
simulated function SetInitialSpeed(optional bool force_speed) // ignored here, we always set the speed
{
    local Rotator R;

    //Log("Pineapple initial speed: "$Speed$" * "$ThrowPower);

    // override physics from start delay...
    SetPhysics(default.Physics);

    Velocity = Speed * ThrowPower * Vector(Rotation);

	R = Rotation;
	R.Roll = -8192;
	SetRotation(R);

    StartRotation = Rotation;
}

//==================================================================
// PostNetBeginPlay
//
// Handle interaction of detonation delay and start delay
//==================================================================
simulated event PostNetBeginPlay()
{
    if (Level.NetMode == NM_Client)
    {
        DetonateDelay = ClientDetonateDelay;
    }

	super.PostNetBeginPlay();
}

//==================================================================
// SetThrowPowerAndDelay
//
// Server side only.
//
// Set throw power and detonation delay from firemode, which is 
// aware of both
//==================================================================
function SetThrowPowerAndDelay(float NewThrowPower, float NewDelay)
{
	NewDelay = FMax(NewDelay, 0.1);

    if (NewDelay < StartDelay)
    {
        DetonateDelay = NewDelay;
		StartDelay = DetonateDelay / 2;
    }
    else 
        DetonateDelay = NewDelay;

    ClientDetonateDelay = DetonateDelay - StartDelay;
}

//==================================================================
// Timer
//
// Either set projectile as visible, when start delay expires,
// or cause explosion
//==================================================================
simulated event Timer()
{
	if (StartDelay > 0)
	{
        ShowAfterStartDelay();
		return;
	}

    HitActor = None;

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

defaultproperties
{
     DetonateDelay=3
     bNoInitialSpin=True
     bRandomStartRotation=False
	 // disable start delay for now. needs animation-level fix.
     //StartDelay=0.300000
     NetTrappedDelay=1.000000
     LifeSpan=6.000000
     DrawScale=0.200000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bUseCylinderCollision=False
     RotationRate=(Roll=0)
}
