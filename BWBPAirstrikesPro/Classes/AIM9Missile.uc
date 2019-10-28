//-----------------------------------------------------------
// Seeker missile.  Finds a target, then pursues it.
//-----------------------------------------------------------
class AIM9Missile extends AIM9Rocket;

var(Lock)       float           LockTime;
var(Lock)       range           LockDelay;
var(Lock)       bool            bLocked;
var(Lock)       float           MaxLockRange;
var(Lock)       bool            bSelfDestruct;

/** Returns a value in R proportional to Factor, where 0 <= Factor <= 1. */
static final function float Relate(float RelativeValue, Range R)
{
    return R.Min + (R.Max - R.Min) * RelativeValue;
}

event PostNetBeginPlay()
{
    super.PostNetBeginPlay();

    SetLockTime();
}

function SetLockTime()
{
    LockTime = Level.TimeSeconds + Relate(FRand(), LockDelay);
}

event Tick(float DeltaTime)
{
    super.Tick(DeltaTime);
    
    CheckLock();
}

function CheckLock()
{
    if(GetTarget() == none
    && Level.TimeSeconds > LockTime)
    {
        // Find a(nother) target.
        Lock();

        // Still nothing?
        if(bSelfDestruct
        && GetTarget() == none)
        {
            // Give up and die.
            TakeDamage(20000, none, Location, Velocity, none);
        }
    }
}

function Lock()
{
    LockTarget = AcquirePawn();
}

// Find the nearest occupied enemy vehicle.
function Vehicle AcquireVehicle()
{
    local Vehicle V, Best;
    local float CurrentDistance, ShortestDistance;

    ShortestDistance = MaxLockRange;

    for(V = Level.Game.VehicleList; V != None; V = V.NextVehicle)
    {
        if(Instigator.GetTeamNum() != V.GetTeamNum()
        && V.Health > 0
        && !V.IsVehicleEmpty())
        {
            CurrentDistance = VSize(V.Location - Location);

            if(CurrentDistance < ShortestDistance)
            {
                if(FastTrace(V.Location))
                {
                    Best = V;
                    ShortestDistance = CurrentDistance;
                }
            }
        }
    }

    return Best;
}

// Find the nearest enemy.
function Pawn AcquirePawn()
{
    local Pawn Target;
    local float Aim;
    local float Distance;

    if(Instigator != none
    && Instigator.Controller != none)
    {
        Target = Instigator.Controller.PickTarget(Aim, Distance, vector(Rotation), Location, MaxLockRange);
    }

    return Target;
}

defaultproperties
{
     LockDelay=(Min=0.010000,Max=0.020000)
     MaxLockRange=30000.000000
}
