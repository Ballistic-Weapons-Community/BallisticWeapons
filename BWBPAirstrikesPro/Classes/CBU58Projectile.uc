//-----------------------------------------------------------
//
//-----------------------------------------------------------
class CBU58Projectile extends AirstrikeProjectile;

#exec OBJ LOAD FILE=..\Sounds\VMVehicleSounds-S.uax

var Emitter SmokeTrailEffect;
var bool bHitWater;
var Effects Corona;
var vector Dir;
var() vector ShakeRotMag;           // how far to rot view
var() vector ShakeRotRate;          // how fast to rot view
var() float  ShakeRotTime;          // how much time to rot the instigator's view
var() vector ShakeOffsetMag;        // max view offset vertically
var() vector ShakeOffsetRate;       // how fast to offset view vertically
var() float  ShakeOffsetTime;       // how much time to offset view
var class<Emitter> ExplosionEffectClass;
var float	ExploStart;

var bool bExploded;


simulated function Destroyed()
{
	if ( SmokeTrailEffect != None )
		SmokeTrailEffect.Kill();
	if ( Corona != None )
		Corona.Destroy();
	Super.Destroyed();
}

function BlowUp(vector HitLocation)
{
	MakeNoise(1.0);
	SetPhysics(PHYS_None);
	bHidden = true;
    GotoState('Dying');
}

simulated function PostBeginPlay()
{
	if ( Level.NetMode != NM_DedicatedServer)
	{
        SmokeTrailEffect = Spawn(class'NewTracer',self);
		Corona = Spawn(class'RocketCorona',self);
	}

	Dir = vector(Rotation);
	Velocity = speed * Dir;
	if (PhysicsVolume.bWaterVolume)
	{
		bHitWater = True;
		Velocity=0.6*Velocity;
	}
    if ( Level.bDropDetail )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	Super.PostBeginPlay();
}

simulated function Landed( vector HitNormal )
{
	Explode(Location,HitNormal);
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
	if ( (Other != instigator) && (!Other.IsA('Projectile') || Other.bProjTarget) )
		Explode(HitLocation,Vect(0,0,1));
}

state Dying
{
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType) {}
	function Timer() 
	{
	    HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, Location);
		if (Level.TimeSeconds - ExploStart > 15)
		{
			SetTimer(0.0, false);
			Destroy();
		}
	}
    function BeginState()
    {
		ExploStart = Level.TimeSeconds;
		bHidden = true;
		SetPhysics(PHYS_None);
		SetCollision(false,false,false);
		Spawn(class'IonCore',,, Location, Rotation);
		ShakeView();
		InitialState = 'Dying';
		SetTimer(0, false);
		PlaySound(sound'WeaponSounds.Redeemer_explosionsound');
    }

    function ShakeView()
    {
        local Controller C;
        local PlayerController PC;
        local float Dist, Scale;

        for ( C=Level.ControllerList; C!=None; C=C.NextController )
        {
            PC = PlayerController(C);
            if ( PC != None && PC.ViewTarget != None )
            {
                Dist = VSize(Location - PC.ViewTarget.Location);
                if ( Dist < DamageRadius * 2.0)
                {
                    if (Dist < DamageRadius)
                        Scale = 1.0;
                    else
                        Scale = (DamageRadius*2.0 - Dist) / (DamageRadius);
                    C.ShakeView(ShakeRotMag*Scale, ShakeRotRate, ShakeRotTime, ShakeOffsetMag*Scale, ShakeOffsetRate, ShakeOffsetTime);
                }
            }
        }
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (bExploded)
		return;
	PlaySound(sound'WeaponSounds.BExplosion3',,5.5*TransientSoundVolume);
    if ( EffectIsRelevant(Location,false) )
    {
    	Spawn(class'NewExplosionA',,,HitLocation + HitNormal*16, rotator(HitNormal) + rot(-16384,0,0));
		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
    }
	
	Spawn(ExplosionEffectClass,,, HitLocation, Rot(0,16384,0));
	
	bExploded = True;

	BlowUp(HitLocation);
	if (Level.NetMode == NM_Client)
		Destroy();
}

defaultproperties
{
     ShakeRotMag=(Z=250.000000)
     ShakeRotRate=(Z=2500.000000)
     ShakeRotTime=6.000000
     ShakeOffsetMag=(Z=10.000000)
     ShakeOffsetRate=(Z=200.000000)
     ShakeOffsetTime=10.000000
     ExplosionEffectClass=Class'BWBPAirstrikesPro.SmallNapalmExplosion'
     Speed=298000.000000
     MaxSpeed=300000.000000
     Damage=50.000000
     DamageRadius=500.000000
     MyDamageType=Class'BWBPAirstrikesPro.DamTypeMK77'
     ExplosionDecal=Class'BWBPAirstrikesPro.ClusterBlastMark'
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'WeaponStaticMesh.RocketProj'
     LifeSpan=15.000000
     AmbientGlow=96
     FluidSurfaceShootStrengthMod=10.000000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=1000.000000
     TransientSoundVolume=1.000000
     TransientSoundRadius=1000.000000
     bFixedRotationDir=True
     RotationRate=(Roll=50000)
     DesiredRotation=(Roll=30000)
     ForceType=FT_Constant
     ForceRadius=100.000000
     ForceScale=5.000000
}
