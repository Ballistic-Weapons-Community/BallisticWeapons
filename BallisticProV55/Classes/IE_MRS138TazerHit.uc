//=============================================================================
// IE_MRS138TazerHit.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_MRS138TazerHit extends BallisticEmitter
	placeable;

defaultproperties
{
     EmitterZTestSwitches(0)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.117857,Color=(B=107,G=96,R=92,A=255))
         ColorScale(2)=(RelativeTime=0.235714,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.400000,Color=(B=110,G=114,R=160,A=255))
         ColorScale(4)=(RelativeTime=0.567857,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.800000))
         FadeOutStartTime=0.110000
         FadeInEndTime=0.025000
         MaxParticles=1
         StartSizeRange=(X=(Max=120.000000),Y=(Max=120.000000),Z=(Max=120.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.600000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_MRS138TazerHit.SpriteEmitter0'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=2.000000)
         TimeBeforeVisibleRange=(Min=0.050000,Max=0.050000)
         TimeBetweenSegmentsRange=(Min=0.150000,Max=0.250000)
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-40.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.600000),Y=(Min=0.600000,Max=0.900000))
         FadeOutStartTime=0.364000
         FadeInEndTime=0.084000
         MaxParticles=30
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.800000)
         StartVelocityRange=(X=(Max=300.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
     End Object
     Emitters(1)=SparkEmitter'BallisticProV55.IE_MRS138TazerHit.SparkEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.471429,Color=(G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.600000
         FadeInEndTime=0.100000
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=80.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-20.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_MRS138TazerHit.SpriteEmitter1'

     AutoDestroy=True
}
