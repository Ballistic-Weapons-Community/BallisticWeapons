class X93IonEffect extends Actor;

#exec OBJ LOAD FILE=XEffectMat.utx

var Vector HitLocation, HitNormal;
var X93IonShaft X93IonShaft;
var X93IonCore X93IonCore;
var float StartTime;
var() float DropTime;

replication
{
    reliable if (bNetInitial && Role == ROLE_Authority)
        HitLocation, HitNormal;
}

function AimAt(Vector hl, Vector hn)
{
    HitLocation = hl;
    HitNormal = hn;
    if (Level.NetMode != NM_DedicatedServer)
        SpawnEffects();
}

simulated function PostNetBeginPlay()
{
    if (Role < ROLE_Authority)
        SpawnEffects();
}

simulated function SpawnEffects()
{
    X93IonCore = Spawn(class'X93IonCore',,, Location, Rotation);
    X93IonShaft = Spawn(class'X93IonShaft',,, Location, Rotation);
    X93IonShaft.mSpawnVecA = Location;
    GotoState('Drop');
}

state Drop
{
    simulated function BeginState()
    {
        StartTime = Level.TimeSeconds;
        SetTimer(DropTime, false);
    }

    simulated function Tick(float dt)
    {
        local float Delta;
        Delta = FMin((Level.TimeSeconds - StartTime) / DropTime, 1.0);
        X93IonCore.SetLocation(Location*(1.0-Delta) + HitLocation*delta);
        X93IonShaft.SetLocation(X93IonCore.Location);
    }

    simulated function Timer()
    {
        local Rotator NormalRot;
        local Actor A;
		
        X93IonShaft.SetLocation(X93IonCore.Location);
        X93IonCore.Destroy();
        X93IonShaft.mAttenuate = true;

        if (Abs(HitNormal.Z) < 0.8)
            NormalRot = Rotator(HitLocation - Location);
        else
            NormalRot = Rotator(HitNormal);

       A = Spawn(class'X93Explosion',,, HitLocation+Vect(0,0,100), Rot(0,16384,0));
       A.RemoteRole = ROLE_None;
       GotoState('');
    }
}

defaultproperties
{
     DropTime=0.500000
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=140
     LightBrightness=255.000000
     LightRadius=12.000000
     DrawType=DT_None
     bDynamicLight=True
     bNetTemporary=True
     bAlwaysRelevant=True
     bReplicateMovement=False
     bSkipActorPropertyReplication=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=2.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=5000.000000
}
