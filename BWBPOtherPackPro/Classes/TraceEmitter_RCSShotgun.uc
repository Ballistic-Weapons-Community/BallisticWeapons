//=============================================================================
// TraceEmitter_RCSShotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_RCSShotgun extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
}

defaultproperties
{
     Begin Object Class=SparkEmitter Name=SparkEmitter6
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.010000,Max=0.050000)
         UseCollision=True
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=162,G=144,R=85,A=255))
         ColorScale(1)=(RelativeTime=0.107143,Color=(B=108,G=96,R=58,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=64,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         FadeOutStartTime=0.110000
         CoordinateSystem=PTCS_Relative
         MaxParticles=12
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=100.000000,Max=4000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=200.000000))
     End Object
     Emitters(0)=SparkEmitter'BWBPOtherPackPro.TraceEmitter_RCSShotgun.SparkEmitter6'

     Begin Object Class=MeshEmitter Name=MeshEmitter15
         StaticMesh=StaticMesh'BallisticHardware2.Effects.VBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.700000,Max=0.800000),Z=(Min=0.200000,Max=0.500000))
         Opacity=0.320000
         FadeOutStartTime=0.045000
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Y=(Min=-0.250000,Max=-0.250000))
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.500000,Max=1.200000),Y=(Min=0.500000,Max=1.200000),Z=(Min=2.000000,Max=8.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
         StartVelocityRange=(X=(Min=100.000000,Max=300.000000))
     End Object
     Emitters(1)=MeshEmitter'BWBPOtherPackPro.TraceEmitter_RCSShotgun.MeshEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.600000
         FadeOutStartTime=0.050000
         FadeInEndTime=0.004000
         MaxParticles=2
         //StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.TraceEmitter_RCSShotgun.SpriteEmitter3'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamDistanceRange=(Min=100.000000,Max=100.000000)
         DetermineEndPointBy=PTEP_Distance
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         HighFrequencyPoints=5
         UseBranching=True
         BranchProbability=(Min=1.000000,Max=1.000000)
         BranchEmitter=0
         BranchSpawnAmountRange=(Min=4.000000,Max=4.000000)
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(A=255))
         ColorMultiplierRange=(Y=(Min=0.200000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.140000
         FadeOutStartTime=0.110600
         CoordinateSystem=PTCS_Relative
         MaxParticles=8
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.WaterSpray1Alpha'
         LifetimeRange=(Min=0.269000,Max=0.269000)
         StartVelocityRange=(X=(Min=70.000000,Max=70.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(3)=BeamEmitter'BWBPOtherPackPro.TraceEmitter_RCSShotgun.BeamEmitter3'

}
