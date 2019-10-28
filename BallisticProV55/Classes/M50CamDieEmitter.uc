//=============================================================================
// M50CamDieEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50CamDieEmitter extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SparkEmitter Name=SparkEmitter1
         LineSegmentsRange=(Min=2.000000,Max=2.000000)
         TimeBeforeVisibleRange=(Min=5.000000,Max=5.000000)
         TimeBetweenSegmentsRange=(Min=0.200000,Max=0.200000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=128,G=255,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=255))
         FadeOutFactor=(X=0.500000,Y=0.500000,Z=0.500000)
         FadeOutStartTime=0.300000
         MaxParticles=20
         StartLocationRange=(Y=(Min=-10.000000,Max=10.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerRange=(Min=15.000000,Max=20.000000)
         SpawnOnTriggerPPS=500000.000000
         StartVelocityRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-50.000000,Max=200.000000))
     End Object
     Emitters(0)=SparkEmitter'BallisticProV55.M50CamDieEmitter.SparkEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         TriggerDisabled=False
         FadeOutStartTime=1.000000
         MaxParticles=15
         SpinsPerSecondRange=(X=(Max=0.700000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=40.000000,Max=50.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.M50CamDieEmitter.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=200,G=230,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=128,R=192))
         FadeOutStartTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=50.000000,Max=60.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=500000.000000
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.M50CamDieEmitter.SpriteEmitter0'

     AutoDestroy=True
}
