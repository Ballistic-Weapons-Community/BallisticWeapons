//=============================================================================
// BG_HeadExplodeBot.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_HeadExplodeBot extends BW_HitGoreEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000),Y=(Min=0.400000),Z=(Min=0.800000))
         FadeOutStartTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=20.000000,Max=40.000000))
         InitialParticlesPerSecond=4000.000000
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_HeadExplodeBot.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000),Z=(Min=0.700000,Max=0.800000))
         FadeOutStartTime=0.182000
         MaxParticles=25
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=6.000000,Max=16.000000),Y=(Min=6.000000,Max=16.000000),Z=(Min=6.000000,Max=16.000000))
         InitialParticlesPerSecond=4000.000000
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.650000,Max=0.650000)
         StartVelocityRange=(X=(Min=20.000000,Max=500.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Max=300.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_HeadExplodeBot.SpriteEmitter9'

     Begin Object Class=MeshEmitter Name=MeshEmitter3
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.482143,Color=(G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.584000
         MaxParticles=15
         SpinsPerSecondRange=(X=(Max=4.000000),Y=(Max=4.000000),Z=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.050000,Max=0.300000),Y=(Min=0.050000,Max=0.300000),Z=(Min=0.050000,Max=0.300000))
         InitialParticlesPerSecond=400.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Max=250.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=50.000000,Max=200.000000))
     End Object
     Emitters(2)=MeshEmitter'BallisticProV55.BG_HeadExplodeBot.MeshEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.100000,Max=0.300000),Z=(Min=0.700000))
         FadeOutStartTime=0.117000
         MaxParticles=25
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=-350.000000,Max=350.000000),Y=(Min=-220.000000,Max=220.000000),Z=(Min=100.000000,Max=300.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BG_HeadExplodeBot.SpriteEmitter10'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=10.000000,Max=75.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyNoiseRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         HighFrequencyPoints=5
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=255,G=128,A=255))
         ColorScale(2)=(RelativeTime=0.332143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         Opacity=0.650000
         FadeOutStartTime=0.060000
         FadeInEndTime=0.036000
         MaxParticles=20
         SizeScale(0)=(RelativeSize=1.500000)
         SizeScale(1)=(RelativeTime=0.280000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'EpicParticles.Beams.BeamFalloff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-1.000000,Max=10.000000))
     End Object
     Emitters(4)=BeamEmitter'BallisticProV55.BG_HeadExplodeBot.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.357510
         FadeInEndTime=0.014020
         MaxParticles=14
         SpinsPerSecondRange=(X=(Max=0.300000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=20.000000,Max=40.000000),Z=(Min=20.000000,Max=40.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Bot.Bot-Saw4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.701000,Max=0.701000)
         StartVelocityRange=(X=(Min=20.000000,Max=150.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=80.000000,Max=200.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.BG_HeadExplodeBot.SpriteEmitter0'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         MaxPointsPerTrail=15
         DistanceThreshold=8.000000
         PointLifeTime=2.000000
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         MaxParticles=5
         StartLocationOffset=(Z=5.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=2.000000,Max=5.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Bot.Bot-Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Max=400.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Max=200.000000))
     End Object
     Emitters(6)=TrailEmitter'BallisticProV55.BG_HeadExplodeBot.TrailEmitter1'

     AutoDestroy=True
}
