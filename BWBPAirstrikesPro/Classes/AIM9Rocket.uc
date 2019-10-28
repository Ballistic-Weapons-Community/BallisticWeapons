// Pull up when breaking off.

//-----------------------------------------------------------
// Generic homing rocket based on AVRiL.
//
// Features added to subclass:
//  - Standard vector homing.
//  - Configurable homing behavior.
//-----------------------------------------------------------
class AIM9Rocket extends AIM9RocketBase;

var(Lock)       float           TurnStrength;
var(Lock)       float           LeadStrength;
// The missile will break off to circle around before coming back to the target
// if this perpendicular to the target.
var(Lock)       float           CircleThreshold;
// Distance to target before the missile circles.
var(Lock)       float           CircleDistance;

/** Lock: Play out the homing process. */
simulated function Home(Actor Target, float DeltaTime)
{
    local vector HomingLocation;
    local vector HomingDirection;
    local float Distance;
    local float Aim;

    HomingLocation = GetHomingLocation(Target);
    HomingDirection = Normal(HomingLocation - Location);

    // Avoid going into a never-ending spiral if the target is perpendicular to
    // movement.
    Aim = HomingDirection dot Normal(Velocity);

    if(Aim < CircleThreshold)
    {
        // Break off until enough distance has been gained to make a full turn.
        Distance = VSize(HomingLocation - Location);

        if(Distance < CircleDistance)
        {
            // Break off.

            // Don't break off into the ground.
            if(HomingLocation.Z > Location.Z)
            {
                PullUp(HomingLocation.Z, DeltaTime);
            }
        }
        else
        {
            // Come back around.
            MoveIn(HomingDirection, DeltaTime);
        }
    }
    else
    {
        MoveIn(HomingDirection, DeltaTime);
    }
}

/** Lock: Get the best route to the target. */
function vector GetHomingLocation(Actor Target)
{
    local vector HomingLocation;

    HomingLocation = GetTargetLocation(Target);

    if(LeadStrength != 0)
    {
        HomingLocation += GetLeadForce(Target);
    }

    return HomingLocation;
}

/** Lock: Get the direction to where the target is going. */
function vector GetLeadForce(Actor Target)
{
    local vector LeadForce;

    LeadForce = Target.Velocity * LeadStrength;

    return LeadForce;
}

/** Lock: Move in on the target.  Standard vector homing. */
function MoveIn(vector HomingDirection, float DeltaTime)
{
    local vector HomingForce;
    local vector NewDirection;

    HomingForce = HomingDirection * TurnStrength * VSize(Velocity) * DeltaTime;
    NewDirection = Normal(Velocity + HomingForce);
    Velocity = NewDirection * VSize(Velocity);
}

/** Lock: Pull up to avoid crashing. */
function PullUp(float DesiredAltitude, float DeltaTime)
{
    local vector PullUpLocation;
    local vector PullUpDirection;

    PullUpLocation = Velocity;
    PullUpLocation.Z = DesiredAltitude;
    PullUpDirection = Normal(PullUpLocation - Location);

    MoveIn(PullUpDirection, DeltaTime);
}

defaultproperties
{
     TurnStrength=3.000000
     LeadStrength=0.100000
     CircleThreshold=0.100000
     CircleDistance=1000.000000
}
