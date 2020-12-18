//=============================================================================
// IE_RSDarkFireBomb.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_RSDarkFireBomb extends BallisticEmitter
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
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.750000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.189000
         FadeInEndTime=0.038500
         MaxParticles=18
         StartLocationRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000))
         SpinsPerSecondRange=(X=(Max=0.250000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=40.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_RSDarkFireBomb.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.750000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.440000
         FadeInEndTime=0.050000
         MaxParticles=25
         StartLocationRange=(X=(Min=-80.000000,Max=80.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=15.000000,Max=20.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=15.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_RSDarkFireBomb.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         Opacity=0.510000
         FadeOutStartTime=1.230000
         FadeInEndTime=0.540000
         MaxParticles=15
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=35.000000,Max=50.000000))
         SpinsPerSecondRange=(X=(Max=0.075000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=75.000000),Y=(Min=75.000000),Z=(Min=75.000000))
         InitialParticlesPerSecond=40.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects2.Particles.NewSmoke1f'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=75.000000,Max=100.000000))
         VelocityLossRange=(Z=(Max=0.500000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_RSDarkFireBomb.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-450.000000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.750000),Z=(Min=0.250000,Max=0.550000))
         FadeOutStartTime=2.280000
         FadeInEndTime=0.090000
         MaxParticles=15
         AlphaRef=200
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=16.000000,Max=16.000000),Y=(Min=16.000000,Max=16.000000),Z=(Min=16.000000,Max=16.000000))
         InitialParticlesPerSecond=99999.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=3.000000)
         StartVelocityRange=(X=(Min=-450.000000,Max=450.000000),Y=(Min=-450.000000,Max=450.000000),Z=(Min=-100.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_RSDarkFireBomb.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=64,R=192,A=255))
         FadeOutStartTime=0.472000
         MaxParticles=1100
         AddLocationFromOtherEmitter=3
         SpinsPerSecondRange=(X=(Max=0.500000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.750000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.800000)
         StartVelocityRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         AddVelocityFromOtherEmitter=3
         AddVelocityMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.IE_RSDarkFireBomb.SpriteEmitter4'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=0.100000,Max=0.200000)
         TimeBetweenSegmentsRange=(Min=0.050000,Max=0.150000)
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.750000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.440000
         MaxParticles=100
         StartLocationRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000))
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Max=1000.000000))
     End Object
     Emitters(5)=SparkEmitter'BallisticProV55.IE_RSDarkFireBomb.SparkEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.760000,Max=0.760000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.480000
         FadeOutStartTime=0.276000
         MaxParticles=5
         StartLocationOffset=(Z=25.000000)
         StartLocationRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         InitialParticlesPerSecond=100.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.IE_RSDarkFireBomb.SpriteEmitter5'

     AutoDestroy=True
}
