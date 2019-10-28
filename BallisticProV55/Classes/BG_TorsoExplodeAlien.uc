//=============================================================================
// BG_TorsoExplodeAlien.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_TorsoExplodeAlien extends BW_HitGoreEmitter
	placeable;

defaultproperties
{
     DisableDGV(4)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=7.400000
         MaxParticles=35
         SpinsPerSecondRange=(X=(Max=3.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=7.000000),Y=(Min=2.000000,Max=7.000000),Z=(Min=2.000000,Max=7.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.AlienSprites.Alien-TorsoBitsA'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=1000.000000
         LifetimeRange=(Min=8.000000,Max=8.000000)
         StartVelocityRange=(X=(Min=-100.000000,Max=400.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Max=250.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeAlien.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=7.400000
         MaxParticles=6
         SpinsPerSecondRange=(X=(Max=3.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.AlienSprites.Alien-TorsoBitsB'
         TextureUSubdivisions=2
         TextureVSubdivisions=1
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=1000.000000
         LifetimeRange=(Min=8.000000,Max=8.000000)
         StartVelocityRange=(X=(Max=150.000000),Y=(Min=-130.000000,Max=130.000000),Z=(Max=200.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeAlien.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
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
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.720000
         FadeOutStartTime=1.160000
         FadeInEndTime=0.280000
         MaxParticles=12
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=30.000000,Max=40.000000),Z=(Min=30.000000,Max=40.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Min=-10.000000,Max=60.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Max=200.000000))
         VelocityLossRange=(X=(Min=1.300000,Max=1.300000),Y=(Min=1.300000,Max=1.300000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeAlien.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.680000
         MaxParticles=6
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.700000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=80.000000),Y=(Min=80.000000),Z=(Min=80.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=80.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=140.000000,Max=220.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeAlien.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.290000
         MaxParticles=20
         StartLocationRange=(Z=(Max=32.000000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticWeapons2.Effects.SparkA1Alpha'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Max=400.000000))
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeAlien.SpriteEmitter22'

     AutoDestroy=True
}
