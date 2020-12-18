//=============================================================================
// IE_LandMineExplosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_LandMineExplosion extends BallisticEmitter
	placeable;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.250000,Max=0.350000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=1.470000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=5.000000)
         SphereRadiusRange=(Min=-40.000000,Max=-40.000000)
         StartLocationPolarRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000))
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=80.000000,Max=80.000000),Y=(Min=80.000000,Max=80.000000),Z=(Min=80.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=100.000000,Max=300.000000))
         StartVelocityRadialRange=(Min=-300.000000,Max=-300.000000)
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_LandMineExplosion.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         Opacity=0.850000
         FadeOutStartTime=0.810000
         StartLocationOffset=(Z=100.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=500.000000,Max=500.000000))
         VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_LandMineExplosion.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.590000
         FadeOutStartTime=0.021000
         MaxParticles=1
         StartLocationOffset=(Z=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_LandMineExplosion.SpriteEmitter11'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticHardware2.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.600000
         MaxParticles=15
         StartLocationOffset=(Z=10.000000)
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=200.000000,Max=600.000000))
     End Object
     Emitters(3)=MeshEmitter'BallisticProV55.IE_LandMineExplosion.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.900000),Y=(Min=0.400000,Max=0.800000),Z=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=0.076000
         FadeInEndTime=0.026000
         MaxParticles=200
         DetailMode=DM_SuperHigh
         AddLocationFromOtherEmitter=3
         StartSizeRange=(X=(Min=5.000000,Max=15.000000),Y=(Min=5.000000,Max=15.000000),Z=(Min=5.000000,Max=15.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.200000)
         AddVelocityFromOtherEmitter=3
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_LandMineExplosion.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.125000,Color=(B=64,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.275000,Color=(B=120,G=140,R=150,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=100,G=110,R=120,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000),Z=(Min=0.800000))
         Opacity=0.500000
         FadeOutStartTime=0.464000
         MaxParticles=500
         AddLocationFromOtherEmitter=3
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=250.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         AddVelocityFromOtherEmitter=3
         AddVelocityMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.IE_LandMineExplosion.SpriteEmitter13'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.Effects.VBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.160000
         MaxParticles=6
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=2.000000,Max=8.000000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(6)=MeshEmitter'BallisticProV55.IE_LandMineExplosion.MeshEmitter0'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=2.000000)
         TimeBetweenSegmentsRange=(Min=0.050000,Max=0.200000)
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.430000
         MaxParticles=80
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Max=500.000000))
     End Object
     Emitters(7)=SparkEmitter'BallisticProV55.IE_LandMineExplosion.SparkEmitter0'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
}
