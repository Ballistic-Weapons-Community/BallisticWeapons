//=============================================================================
// BallisticHandGrenadeProjectile.
//
// Cookable hand grenades with variable throw distance.
//
// Azarael
//=============================================================================
class BallisticHandGrenadeProjectile extends BallisticGrenade
	abstract;

var() int		FireModeNum;		// Da fire mode that spawned dis grenade

var float   	ClientSpeed;
var float   	ClientDetonateDelay;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		ClientSpeed, ClientDetonateDelay;
}

//==================================================================
// ApplyParams
//
// Override values set by params with client replicated values
//==================================================================
simulated function ApplyParams(ProjectileEffectParams params)
{
    Super.ApplyParams(params);

	if (Role < ROLE_Authority)
	{
		Speed = ClientSpeed;
		DetonateDelay = ClientDetonateDelay;
	}
}

//==================================================================
// SetInitialSpeed
//
// Always set speed
//==================================================================
simulated function SetInitialSpeed(optional bool force_speed) // ignored here, we always set the speed
{
    local Rotator R;

    // override physics from start delay...
    SetPhysics(default.Physics);

    Velocity = Vector(Rotation) * Speed;

	R = Rotation;
	R.Roll = -8192;
	SetRotation(R);

    StartRotation = Rotation;
}

//==================================================================
// SetSpeedAndDelay
//
// Server side only.
//
// Set throw power and detonation delay from firemode, which is 
// aware of both
//==================================================================
function SetSpeedAndDelay(float NewSpeed, float NewDelay)
{
	Speed = NewSpeed;
	ClientSpeed = NewSpeed;

	NewDelay = FMax(NewDelay, 0.1);

    if (NewDelay < StartDelay)
    {
        DetonateDelay = NewDelay;
		StartDelay = DetonateDelay / 2;
    }
    else 
        DetonateDelay = NewDelay;

	 ClientDetonateDelay = DetonateDelay - StartDelay;

	// this function is called after PostNetBeginPlay
	// so these need to be redone
	SetInitialSpeed();

	if (DetonateOn == DT_Timer)
        SetTimer(DetonateDelay, false);
}

//==================================================================
// Timer
//
// Either set projectile as visible, when start delay expires,
// or cause explosion
//==================================================================
simulated function Timer()
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
