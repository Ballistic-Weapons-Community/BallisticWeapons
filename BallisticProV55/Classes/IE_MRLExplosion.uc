//=============================================================================
// IE_MRLExplosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_MRLExplosion extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=50.000000)
         ExtentMultiplier=(X=0.400000,Y=0.400000,Z=0.400000)
         ColorScale(0)=(Color=(B=255,G=255,R=225,A=255))
         ColorScale(1)=(RelativeTime=0.114286,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.590000
         FadeOutStartTime=1.200000
         FadeInEndTime=0.450000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=0.500000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScale(3)=(RelativeTime=0.370000,RelativeSize=0.900000)
         SizeScale(4)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=80.000000),Y=(Min=60.000000,Max=80.000000),Z=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRadialRange=(Min=-150.000000,Max=-100.000000)
         VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_MRLExplosion.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.800000
         FadeOutStartTime=0.161000
         FadeInEndTime=0.031500
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_MRLExplosion.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         UseDirectionAs=PTDU_Up
         UseMaxCollisions=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ExtentMultiplier=(X=0.700000,Y=0.700000,Z=0.700000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MaxCollisions=(Min=1.000000,Max=1.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.346429,Color=(G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255))
         FadeOutStartTime=0.185000
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=10.000000,Max=20.000000)
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=10.000000,Max=30.000000),Y=(Min=10.000000,Max=30.000000),Z=(Min=10.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(Z=(Min=100.000000,Max=300.000000))
         StartVelocityRadialRange=(Min=-800.000000,Max=-500.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.IE_MRLExplosion.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.IE_MRLExplosion.SpriteEmitter14'

     AutoDestroy=True
     bDeferRendering=False
}
