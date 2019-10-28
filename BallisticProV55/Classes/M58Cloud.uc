//=============================================================================
// M58Cloud.
//
// A screening cloud of gas for a smoke grenade.
//
// A modification of code by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M58Cloud extends BallisticEmitter
	placeable;
	
const LIFETIME = 8;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

		if (level.netMode == NM_DedicatedServer)
		{
			Emitters[0].Disabled = true;
			Emitters[1].Disabled = true;
		}
	SetTimer(LIFETIME, false);
}

function Reset()
{
	Destroy();
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

simulated function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
		Kill();
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=4.000000
         FadeInEndTime=0.400000
         MaxParticles=24
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000),Z=(Min=-16.000000,Max=48.000000))
         SpinsPerSecondRange=(X=(Max=0.010000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=250.000000,Max=300.000000),Y=(Min=250.000000,Max=300.000000),Z=(Min=250.000000,Max=300.000000))
         ParticlesPerSecond=4.000000
         InitialParticlesPerSecond=4.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1g'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-70.000000,Max=70.000000),Y=(Min=-70.000000,Max=70.000000),Z=(Min=-10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.M58Cloud.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=70.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=2.600000
         FadeInEndTime=0.400000
         MaxParticles=20
         StartLocationRange=(X=(Min=-256.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Max=0.030000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         ParticlesPerSecond=4.000000
         InitialParticlesPerSecond=4.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.M58Cloud.SpriteEmitter0'

     AutoDestroy=True
     CollisionRadius=192.000000
     CollisionHeight=192.000000
     bCollideActors=True
     bUseCylinderCollision=True
     bNotOnDedServer=False
}
