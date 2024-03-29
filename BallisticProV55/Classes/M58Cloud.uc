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
	
const LIFETIME = 15;

var() float		ThermalBlockRadius; // defeats threat highlighting within this radius

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Level.NetMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled = true;
		Emitters[1].Disabled = true;
	}

	else 
	{
		PlaySound(sound'BW_Core_WeaponSound.T10.T10-Ignite',, 0.7,, 128, 1.0, true);
		AmbientSound = Sound'BW_Core_WeaponSound.T10.T10-toxinLoop';
	}

	SetTimer(LIFETIME, false);
}

function Reset()
{
	Destroy();
}

simulated function Timer()
{
	if (Level.NetMode == NM_DedicatedServer)
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
         StartLocationRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000),Z=(Min=-16.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Max=0.010000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=200.000000,Max=250.000000),Y=(Min=200.000000,Max=250.000000),Z=(Min=200.000000,Max=250.000000))
         ParticlesPerSecond=4.000000
         InitialParticlesPerSecond=4.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1g'
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
         StartLocationRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000))
         SpinsPerSecondRange=(X=(Max=0.030000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         ParticlesPerSecond=4.000000
         InitialParticlesPerSecond=4.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.M58Cloud.SpriteEmitter0'

     AutoDestroy=True
     CollisionRadius=192.000000
     CollisionHeight=192.000000
     bCollideActors=False
     bUseCylinderCollision=True
     bNotOnDedServer=False

	 bNetTemporary=True
	 bAlwaysRelevant=True
	 RemoteRole=ROLE_SimulatedProxy
}
