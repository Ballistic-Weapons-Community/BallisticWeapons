//=============================================================================
// xscorch
//=============================================================================
class PermanentScorch extends Projector
	abstract;

var() float Lifetime;
var() float PushBack;
var() bool  RandomOrient;

event PreBeginPlay()
{
	local PlayerController PC;

    if ( (Level.NetMode == NM_DedicatedServer) || (Level.DecalStayScale == 0.f) )
    {
        return;
    }
	PC = Level.GetLocalPlayerController();
	if ( PC.BeyondViewDistance(Location, CullDistance) )
    {
        return;
    }

	Super.PreBeginPlay();
}

function PostBeginPlay()
{
    local Vector RX, RY, RZ;
    local Rotator R;

	if ( PhysicsVolume.bNoDecals )
	{
		Destroy();
		return;
	}
    if( RandomOrient )
    {
        R.Yaw = 0;
        R.Pitch = 0;
        R.Roll = Rand(65535);
        GetAxes(R,RX,RY,RZ);
        RX = RX >> Rotation;
        RY = RY >> Rotation;
        RZ = RZ >> Rotation;
        R = OrthoRotation(RX,RY,RZ);
        SetRotation(R);
    }
    SetLocation( Location - Vector(Rotation)*PushBack );
    Super.PostBeginPlay();
}

defaultproperties
{
     PushBack=24.000000
     RandomOrient=True
     FOV=1
     MaxTraceDistance=70000
     bProjectActor=False
     bClipBSP=True
     FadeInTime=0.125000
     bStatic=False
     LifeSpan=1000.000000
     bGameRelevant=True
}
