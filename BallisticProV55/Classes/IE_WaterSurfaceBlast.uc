//=============================================================================
// IE_WaterSurfaceBlast.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_WaterSurfaceBlast extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         MaxPointsPerTrail=50
         DistanceThreshold=8.000000
         MaxTrailTwistAngle=25
         PointLifeTime=2.000000
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-800.000000)
         ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.950000,Max=0.950000))
         FadeOutStartTime=1.500000
         FadeInEndTime=0.100000
         MaxParticles=15
         StartLocationOffset=(Z=-128.000000)
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=160.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=1500.000000,Max=1600.000000))
         VelocityLossRange=(Z=(Min=2.500000,Max=2.500000))
     End Object
     Emitters(0)=TrailEmitter'BallisticProV55.IE_WaterSurfaceBlast.TrailEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.VolumetricA4'
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
         Acceleration=(Z=150.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.950000,Max=0.950000))
         Opacity=0.660000
         FadeOutStartTime=0.870000
         FadeInEndTime=0.585000
         MaxParticles=2
         StartLocationOffset=(Z=-180.000000)
         SpinsPerSecondRange=(Z=(Max=0.100000))
         StartSpinRange=(Y=(Min=0.250000,Max=0.250000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=0.560000,RelativeSize=0.500000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=1.400000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=10.000000,Max=12.000000),Z=(Min=10.000000,Max=12.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(Z=(Min=120.000000,Max=120.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.IE_WaterSurfaceBlast.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.120000
         FadeInEndTime=0.460000
         MaxParticles=50
         StartLocationOffset=(Z=-128.000000)
         StartLocationRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000))
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000),Z=(Min=3.000000,Max=5.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterParticle1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=500.000000,Max=1000.000000))
         VelocityLossRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_WaterSurfaceBlast.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.430000
         FadeInEndTime=0.160000
         MaxParticles=8
         StartLocationOffset=(Z=2.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.560000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=250.000000),Y=(Max=250.000000),Z=(Max=250.000000))
         InitialParticlesPerSecond=5.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'BW_Core_WeaponTex.Particles.RippleA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_WaterSurfaceBlast.SpriteEmitter0'

     AutoDestroy=True
}
