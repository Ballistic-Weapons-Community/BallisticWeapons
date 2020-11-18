//=============================================================================
// IE_MinigunBulletConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_XM20AutoLas extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.700000
         FadeOutStartTime=1.065000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=45.000000),Y=(Min=20.000000,Max=45.000000),Z=(Min=20.000000,Max=45.000000))
         InitialParticlesPerSecond=10000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=60.000000,Max=100.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-5.000000,Max=20.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.IE_XM20AutoLas.SpriteEmitter28'

     Begin Object Class=MeshEmitter Name=MeshEmitter14
         StaticMesh=StaticMesh'BallisticHardware2.Effects.VolumetricA3'
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
         FadeOutStartTime=0.085000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(1)=MeshEmitter'BWBPOtherPackPro.IE_XM20AutoLas.MeshEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.314286,Color=(B=64,G=224,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=16,G=64,R=255,A=255))
         FadeOutStartTime=0.060000
         MaxParticles=3
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=5.000000,Max=12.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticWeapons2.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=50.000000,Max=300.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.IE_XM20AutoLas.SpriteEmitter3'

     Emitters(3)=SpriteEmitter'BallisticProV55.IE_BulletMetal.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.220000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.350000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=254,R=255,A=255))
         ColorMultiplierRange=(X=(Min=5.500000,Max=0.600000),Z=(Min=0.400000,Max=0.400000))
         Opacity=0.700000
         FadeOutStartTime=0.150000
         MaxParticles=5
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Min=0.450000,Max=0.550000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPOtherPackPro.IE_XM20AutoLas.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         FadeOutStartTime=0.095000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=40.000000),Y=(Max=40.000000),Z=(Max=40.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(5)=SpriteEmitter'BWBPOtherPackPro.IE_XM20AutoLas.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=100,G=200,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.425000,Color=(B=50,G=50,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=0,G=0,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=1.000000))
         FadeOutStartTime=0.110000
         FadeInEndTime=0.110000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=25.000000,Max=30.000000),Y=(Min=25.000000,Max=30.000000),Z=(Min=25.000000,Max=30.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(6)=SpriteEmitter'BWBPOtherPackPro.IE_XM20AutoLas.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.200000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=8.500000,Max=8.500000),Y=(Min=8.500000,Max=8.500000),Z=(Min=8.500000,Max=8.500000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPOtherPackPro.IE_XM20AutoLas.SpriteEmitter14'

     AutoDestroy=True
}
