class PD97TazerTrail extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=PD97TazerTrailEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=48))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=150,G=64))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=48,A=255))
         Opacity=0.400000
         FadeOutStartTime=0.300000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSizeRange=(X=(Min=12.000000,Max=8.000000))
         ParticlesPerSecond=1.000000
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2k4XP.Weapons.ShockTankEffectCore2Ga'
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.PD97TazerTrail.PD97TazerTrailEmitter1'

     Begin Object Class=SparkEmitter Name=PD97TazerSparkEmitter1
         LineSegmentsRange=(Min=4.000000,Max=4.000000)
         TimeBeforeVisibleRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.050000,Max=0.050000)
         FadeOut=True
         ResetAfterChange=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-450.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.040000
         CoordinateSystem=PTCS_Relative
         ParticlesPerSecond=5.000000
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2k4XP.Cicada.LongSpark'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Min=-150.000000,Max=150.000000))
     End Object
     Emitters(1)=SparkEmitter'BWBPOtherPackPro.PD97TazerTrail.PD97TazerSparkEmitter1'

     bNoDelete=False
}
