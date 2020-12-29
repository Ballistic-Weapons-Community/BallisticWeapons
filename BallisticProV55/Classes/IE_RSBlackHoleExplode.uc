//=============================================================================
// IE_RSBlackHoleExplode.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSBlackHoleExplode extends BallisticEmitter
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000))
         FadeOutStartTime=0.235000
         FadeInEndTime=0.005000
         MaxParticles=6
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
         InitialParticlesPerSecond=8.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSBlackHoleExplode.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         Opacity=0.820000
         FadeOutStartTime=0.115000
         FadeInEndTime=0.020000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.GunFire.RailShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSBlackHoleExplode.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         ProjectionNormal=(X=1.000000,Z=0.000000)
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
         Opacity=0.670000
         FadeOutStartTime=0.115000
         FadeInEndTime=0.020000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.GunFire.RailShock'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RSBlackHoleExplode.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         ProjectionNormal=(X=1.000000,Z=0.000000)
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
         ColorMultiplierRange=(Y=(Min=0.700000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.670000
         FadeOutStartTime=0.182000
         FadeInEndTime=0.019500
         MaxParticles=2
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=9.000000)
         InitialParticlesPerSecond=10.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterRing1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.650000,Max=0.650000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_RSBlackHoleExplode.SpriteEmitter3'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=1.000000,Max=1024.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-48.000000,Max=48.000000),Y=(Min=-48.000000,Max=48.000000),Z=(Min=-48.000000,Max=48.000000))
         HighFrequencyNoiseRange=(X=(Min=-4.000000,Max=4.000000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         HighFrequencyPoints=8
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.076000
         FadeInEndTime=0.020000
         MaxParticles=12
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-64.000000,Max=64.000000)
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=50.000000),Y=(Min=15.000000,Max=50.000000),Z=(Min=15.000000,Max=50.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRadialRange=(Min=-4.000000,Max=-4.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(4)=BeamEmitter'BallisticProV55.IE_RSBlackHoleExplode.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.185714,Color=(B=96,G=200,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.440000
         MaxParticles=20
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=10.000000,Max=24.000000),Y=(Min=10.000000,Max=24.000000),Z=(Min=10.000000,Max=24.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-1250.000000,Max=1250.000000),Y=(Min=-1250.000000,Max=1250.000000),Z=(Min=-1250.000000,Max=1250.000000))
         VelocityLossRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_RSBlackHoleExplode.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=128,A=255))
         ColorScale(1)=(RelativeTime=0.750000,Color=(G=200,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=64,R=255,A=255))
         FadeOutStartTime=0.210000
         FadeInEndTime=0.160000
         MaxParticles=300
         AddLocationFromOtherEmitter=5
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=6.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=5.000000,Max=5.000000))
         InitialParticlesPerSecond=350.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         AddVelocityFromOtherEmitter=5
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_RSBlackHoleExplode.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=2.000000,Max=2.000000)
         ColorScale(0)=(Color=(B=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=255))
         FadeOutStartTime=2.240000
         FadeInEndTime=1.360000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Max=150.000000),Y=(Max=150.000000),Z=(Max=150.000000))
         InitialParticlesPerSecond=75.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.NewSmoke1f'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=-500.000000,Max=500.000000))
         VelocityLossRange=(X=(Max=6.000000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.IE_RSBlackHoleExplode.SpriteEmitter6'

     AutoDestroy=True
}
