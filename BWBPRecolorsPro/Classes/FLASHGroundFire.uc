//=============================================================================
// AT40 ground fires.
//
// FP7 multihit fix.
// by Azarael based on RuneStorm code
//=============================================================================
class FLASHGroundFire extends BallisticEmitter
	placeable;

var   float				BurnTime;		// How long its been burning
var   AvoidMarker		Fear;			// Da phear spauwt...
var Controller	InstigatorController;
var FLASHFireControl	FireControl;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	BurnTime -= 4*FRand();
	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
	}
}

function Reset()
{
	Destroy();
}

simulated function Terminate(float Delay)
{
	SetTimer(Delay, false);
}

simulated function Timer()
{
	if (level.netMode == NM_DedicatedServer)
		GotoState('DSDying');
	else
		Kill();
}

state DSDying
{
Begin:
	Sleep(3.0);
	Destroy();
}

function Landed(vector HitNormal)
{
	HitWall(HitNormal, none);
}

function HitWall (vector HitNormal, actor Wall)
{
	SetPhysics(PHYS_None);
	if (level.NetMode == NM_Client)
		return;
	bCollideWorld=false;
	SetCollision(true, false, false);
	SetCollisionSize( 70, 100 );
	Fear = Spawn(class'AvoidMarker');
	Fear.SetCollisionSize(120, 120);
    Fear.StartleBots();
}

simulated function Destroyed()
{
	if (Fear!=None)
		Fear.Destroy();
	super.Destroyed();
}

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
	{
		if (level.netMode == NM_DedicatedServer)
			Destroy();
		else
			Kill();
	}
}

defaultproperties
{
     BurnTime=10.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.600000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=0.500000
         MaxParticles=40
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=2.000000,Max=3.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=4.000000,Max=7.000000))
         InitialParticlesPerSecond=60.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=125.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.FP7GroundFire.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.600000,Max=0.700000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=0.400000
         FadeInEndTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(Z=15.000000)
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=30.000000,Max=50.000000))
         InitialParticlesPerSecond=4.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=65.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.FP7GroundFire.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         Acceleration=(Z=60.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.800000),Z=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=0.240000
         FadeInEndTime=0.075000
         MaxParticles=2
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Max=30.000000))
         StartSizeRange=(X=(Min=7.000000,Max=70.000000),Y=(Min=7.000000,Max=70.000000),Z=(Min=7.000000,Max=70.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         LifetimeRange=(Min=0.100000,Max=0.500000)
         StartVelocityRange=(Z=(Max=30.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.FP7GroundFire.SpriteEmitter10'

     AutoDestroy=True
     Physics=PHYS_Falling
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     bCollideWorld=True
     bUseCylinderCollision=True
     Mass=30.000000
     bNotOnDedServer=False
}
