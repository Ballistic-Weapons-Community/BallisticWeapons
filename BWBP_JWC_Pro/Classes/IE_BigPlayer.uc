//=============================================================================
// IE_BigPlayer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BigPlayer extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.100000
         FadeOutStartTime=1.125000
         FadeInEndTime=0.030000
         MaxParticles=25
         StartLocationRange=(Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=4.000000,Max=15.000000),Y=(Min=4.000000,Max=15.000000),Z=(Min=4.000000,Max=15.000000))
         InitialParticlesPerSecond=999999.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Max=25.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_BigPlayer.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.850000,Max=0.950000),Z=(Min=0.650000,Max=0.750000))
         Opacity=0.100000
         FadeOutStartTime=0.864000
         FadeInEndTime=0.024000
         MaxParticles=25
         StartLocationRange=(Y=(Min=-8.000000,Max=8.000000),Z=(Min=-8.000000,Max=8.000000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=12.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
         InitialParticlesPerSecond=999999.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.200000,Max=1.200000)
         StartVelocityRange=(X=(Min=5.000000,Max=45.000000),Y=(Min=-35.000000,Max=35.000000),Z=(Min=-35.000000,Max=35.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_JWC_Pro.IE_BigPlayer.SpriteEmitter1'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=2.000000,Max=4.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.200000)
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000),Y=(Min=0.500000),Z=(Min=0.800000))
         FadeOutStartTime=0.640000
         FadeInEndTime=0.024000
         MaxParticles=25
         StartLocationRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         InitialParticlesPerSecond=999999.000000
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=20.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SparkEmitter'BWBP_JWC_Pro.IE_BigPlayer.SparkEmitter0'

     AutoDestroy=True
}
