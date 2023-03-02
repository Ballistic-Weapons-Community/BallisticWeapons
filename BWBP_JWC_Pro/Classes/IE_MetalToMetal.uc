//=============================================================================
// IE_MetalToMetal.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_MetalToMetal extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         ZTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
         Opacity=0.440000
         FadeOutStartTime=0.115000
         FadeInEndTime=0.025000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BWBP_JW_Tex.Effects.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.400000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_MetalToMetal.SpriteEmitter2'

     Begin Object Class=SparkEmitter Name=SparkEmitter1
         LineSegmentsRange=(Min=1.000000,Max=2.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.200000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.471429,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.180000
         MaxParticles=15
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'BWBP_JW_Tex.Effects.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Max=200.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-80.000000,Max=80.000000))
     End Object
     Emitters(1)=SparkEmitter'BWBP_JWC_Pro.IE_MetalToMetal.SparkEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.120000
         FadeInEndTime=0.120000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=2.000000)
         SpinsPerSecondRange=(X=(Max=0.030000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=10.000000),Y=(Min=8.000000,Max=10.000000),Z=(Min=8.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Max=5.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_JWC_Pro.IE_MetalToMetal.SpriteEmitter3'

     AutoDestroy=True
}
