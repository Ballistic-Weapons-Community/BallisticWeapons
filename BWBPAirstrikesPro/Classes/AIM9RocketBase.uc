//-----------------------------------------------------------
// Generic homing rocket based on AVRiL.
//
// Features:
//  - Subclasses AVRiL to retain compatibility with Cicada
//    flares, SPMA cameras and whatnot.
//  - Bot support.
//  - Configurable trail and explosion visuals.
//  - Acceleration.
//  - Simple homing.
//-----------------------------------------------------------
class AIM9RocketBase extends AIM9RocketMissile;

var(Explosion)  Sound           ExplosionSound;
var(Explosion)  float           ExplosionCullDistance;
var(Explosion)  class<Emitter>  Explosion;

var(Trail)      class<Emitter>  SmokeTrailClass;
var(Trail)      class<Effects>  CoronaClass;

var(Lock)       Pawn			LockTarget;
var(Lock)       float           WarnTargetInterval;
var(Lock)       float           LastWarnTargetTime;

event PostBeginPlay()
{
    SpawnTrail();
    Launch();

    super(Projectile).PostBeginPlay();
}

/** Tick: Override base class Tick disabling. */
simulated event Tick(float DeltaTime)
{
    CheckHoming(DeltaTime);

    // Do NOT call the super's Tick or it'll disable itself.
}

/** Explosion: Override hardcoded explosion effects. */
event Destroyed()
{
    DestroyTrail();
    SpawnExplosion(Location, Rotation * -1);

    // Projectile does not implement Destroyed.
}

/** Trail: Spawn all trail related effects. */
function SpawnTrail()
{
    if(Level.NetMode != NM_DedicatedServer)
    {
        SmokeTrail = Spawn(SmokeTrailClass,,,Location - 15 * vector(Rotation));
        SmokeTrail.Setbase(self);

        Corona = Spawn(CoronaClass, self);

        if(Level.bDropDetail)
        {
            bDynamicLight = false;
            LightType = LT_None;
        }
    }
}

/** Trail: Clean up all trail related effects. */
function DestroyTrail()
{
    if(SmokeTrail != none)
    {
        // Turn off trail's ambient sound.  Otherwise it'll keep running until
        // all its particles have died.
        SmokeTrail.AmbientSound = none;

        // Turn off smoke emitters.  Emitter should then destroy itself when all
        // particles fade out.
        SmokeTrail.Kill();
    }

    if(Corona != none)
    {
        Corona.Destroy();
    }
}

/** Explosion: Spawn all explosion related effects. */
function SpawnExplosion(vector HitLocation, rotator HitNormal)
{
    local PlayerController PC;

    if(Level.NetMode != NM_DedicatedServer)
    {
        PlaySound(ExplosionSound,, TransientSoundVolume);
    
        if(!bNoFX
        && EffectIsRelevant(Location, false))
        {
            PC = Level.GetLocalPlayerController();

            if(PC.ViewTarget != none
            && VSize(PC.ViewTarget.Location - Location) < ExplosionCullDistance)
            {
                Spawn(Explosion,,, HitLocation + vector(HitNormal) * 16, HitNormal);
            }
        }
    }
}

/** Movement: Set up velocity and acceleration. <br>
    AI: Hold off on warning the target. */
function Launch()
{
    Velocity = vector(Rotation) * Speed;

    if(PhysicsVolume.bWaterVolume)
    {
        Velocity *= 0.6;
    }
    
    // Don't warn the target straight away.
    LastWarnTargetTime = Level.TimeSeconds;
}

/** Movement: Continue acceleration. */
function Accelerate(float DeltaTime)
{
    if(VSize(Velocity) <= MaxSpeed)
    {
        Acceleration += Normal(Velocity) * AccelerationAddPerSec * DeltaTime;
    }
    else
    {
        // No acceleration.
        Acceleration = vect(0,0,0);
    }
}

/** Movement: Orient to velocity. */
function OrientToVelocity()
{
    SetRotation(rotator(Velocity));
}

/** Lock: Check up on the target. */
function CheckHoming(float DeltaTime)
{
    local Actor Target;

    if(Role == ROLE_Authority)
    {
        Target = GetTarget();
    
        if(Target != none)
        {
            Home(Target, DeltaTime);
        }
    
        Accelerate(DeltaTime);
        OrientToVelocity();
    }
}

/** Lock: Check the target for decoys, interference, alternative targets or
          whatever. */
function Actor GetTarget()
{
    if(IsValidTarget(OverrideTarget))
    {
        return OverrideTarget;
    }
    else if(IsValidTarget(LockTarget))
    {
        return LockTarget;
    }
    else
    {
        return none;
    }
}

/** Lock: Validate that the target is still alive. */
function bool IsValidTarget(Actor Target)
{
    local bool bValid;

    if(Target != none)
    {
        if(Pawn(Target) != none)
        {
            if(Pawn(Target).Health > 0)
            {
                bValid = true;
            }
        }
        else
        {
            bValid = true;
        }
    }

    return bValid;
}

/** Lock: Home in on the target.  Simple, perfect homing. */
simulated function Home(Actor Target, float DeltaTime)
{
    local vector HomingLocation;
    local vector HomingDirection;

    HomingLocation = GetHomingLocation(Target);
    HomingDirection = HomingLocation - Location;
    Velocity = Normal(HomingDirection) * VSize(Velocity);
}

/** Lock: Simply get the location of the target. */
function vector GetHomingLocation(Actor Target)
{
    return GetTargetLocation(Target);
}

/** Lock: Get the target's location. */
function vector GetTargetLocation(Actor Target)
{
    if(Pawn(Target) != none)
    {
        // Home in on the target itself.
        return Pawn(Target).GetTargetLocation();
    }
    else
    {
        // Home in on the target's location.
        return Target.Location;
    }
}

/** Lock: Alert the target to the lock. <br>
    AI: Let bots with nothing else to shoot at attempt to shoot down incoming
        missiles. */
function AlertTarget()
{
    if(LockTarget != none
    && LockTarget.Controller != none
    && OverrideTarget != none)
    {
        LockTarget.Controller.ReceiveProjectileWarning(self);
    }

    if(Vehicle(LockTarget) != none)
    {
        Vehicle(LockTarget).IncomingMissile(self);
    }

    AttractBotFire();
}

/** AI: Let bots with nothing else to shoot at attempt to shoot down incoming
        missiles. */
function AttractBotFire()
{
    local array<Vehicle> TargetPawns;
    local int i;

    if(Vehicle(LockTarget) != none)
    {
        TargetPawns = Vehicle(LockTarget).GetTurrets();
        TargetPawns[TargetPawns.length] = Vehicle(LockTarget);
    
        for(i = 0; i < TargetPawns.length; i++)
        {
            TargetPawns[i].ShouldTargetMissile(self);
        }
    }
}

/** AI: Warn the target. */
function WarnTarget(Actor Target)
{
    if(Level.TimeSeconds > LastWarnTargetTime + WarnTargetInterval)
    {
        AlertTarget();

        LastWarnTargetTime = Level.TimeSeconds;
    }
}

/** Explosion: Explode when close to decoys, SPMA cameras et al. */
function CheckOverrideTargetProximity()
{
}

defaultproperties
{
     ExplosionSound=Sound'WeaponSounds.BaseImpactAndExplosions.BExplosion3'
     ExplosionCullDistance=65000.000000
     Explosion=Class'BWBPAirstrikesPro.CarpetBombExplosion'
     SmokeTrailClass=Class'BWBPAirstrikesPro.AIM9MissileTrail'
     CoronaClass=Class'XEffects.RocketCorona'
     WarnTargetInterval=1.000000
     MomentumTransfer=100000.000000
     LifeSpan=30.000000
     SoundRadius=256.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=500.000000
}
