//=============================================================================
// IE_MetalToConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_MetalToConcrete extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.460000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.180000
         MaxParticles=7
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=30.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_MetalToConcrete.SpriteEmitter0'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBeforeVisibleRange=(Min=0.050000,Max=0.050000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.200000)
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.607143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.900000),Z=(Min=0.000000,Max=0.500000))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.100000
         MaxParticles=15
         DetailMode=DM_High
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'BWBP_JW_Tex.Effects.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=80.000000),Y=(Min=-20.000000,Max=40.000000),Z=(Min=-60.000000,Max=20.000000))
     End Object
     Emitters(1)=SparkEmitter'BWBP_JWC_Pro.IE_MetalToConcrete.SparkEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_JW_Static.Impact.ConcreteChip2'
         UseParticleColor=True
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         MaxCollisions=(Min=5.000000,Max=5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=2.340000
         FadeInEndTime=0.360000
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         SpinsPerSecondRange=(X=(Max=1.500000),Y=(Max=1.500000),Z=(Max=1.500000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationDampingFactorRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=0.150000,Max=0.300000),Y=(Min=0.150000,Max=0.300000),Z=(Min=0.150000,Max=0.300000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=300.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Max=50.000000),Y=(Min=-35.000000,Max=35.000000),Z=(Max=75.000000))
     End Object
     Emitters(2)=MeshEmitter'BWBP_JWC_Pro.IE_MetalToConcrete.MeshEmitter0'

     AutoDestroy=True
}
