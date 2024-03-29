//=============================================================================
// Effect spawned when the KHMKII gets destroyed.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class KHMKIIExplosionEffect extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         MaxParticles=1
         StartSizeRange=(X=(Min=0.000000,Max=0.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2004Particles.Energy.SparkHead'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=500.000000,Max=500.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIExplosionEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(A=255))
         ColorScale(2)=(RelativeTime=1.000000)
         MaxParticles=5
         StartLocationRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=10.000000,Max=10.000000))
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.250000)
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIExplosionEffect.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         BlendBetweenSubdivisions=True
         MaxParticles=8
         StartLocationRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-10.000000,Max=10.000000))
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         InitialParticlesPerSecond=10.000000
         Texture=Texture'ExplosionTex.Framed.exp1_frames'
         TextureUSubdivisions=2
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.600000,Max=0.600000)
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIExplosionEffect.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=106,G=196,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(A=255))
         ColorScale(3)=(RelativeTime=1.000000)
         MaxParticles=5
         DetailMode=DM_High
         StartLocationRange=(Z=(Max=15.000000))
         StartLocationShape=PTLS_All
         StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=100.000000,Max=100.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ExplosionTex.Framed.we1_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(3)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIExplosionEffect.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseVelocityScale=True
         MaxParticles=5
         DetailMode=DM_High
         StartLocationRange=(Z=(Max=15.000000))
         StartLocationShape=PTLS_All
         StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=100.000000,Max=100.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=30.000000
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRadialRange=(Min=-150.000000,Max=-150.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
         VelocityScale(0)=(RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(1)=(RelativeTime=0.500000,RelativeVelocity=(X=1.000000,Y=1.000000,Z=1.000000))
         VelocityScale(2)=(RelativeTime=0.750000)
         VelocityScale(3)=(RelativeTime=1.000000)
     End Object
     Emitters(4)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIExplosionEffect.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Opacity=0.500000
         StartLocationRange=(Z=(Max=15.000000))
         StartLocationShape=PTLS_All
         StartLocationPolarRange=(X=(Max=65536.000000),Y=(Min=16384.000000,Max=16384.000000),Z=(Min=80.000000,Max=150.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         InitialParticlesPerSecond=50.000000
         Texture=Texture'ExplosionTex.Framed.exp1_frames'
         TextureUSubdivisions=2
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.700000,Max=0.700000)
         InitialDelayRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(5)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIExplosionEffect.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         AlphaTest=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.750000,Max=0.750000))
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=64,R=64,A=255))
         FadeOutStartTime=7.000000
         MaxParticles=40
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000),Z=(Min=-40.000000,Max=-16.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'VMParticleTextures.VehicleExplosions.GENERICshrapnelTEX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=8.000000,Max=8.000000)
         StartVelocityRadialRange=(Min=400.000000,Max=600.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(6)=SpriteEmitter'BWBP_VPC_Pro.KHMKIIExplosionEffect.SpriteEmitter4'

     AutoDestroy=True
     bNoDelete=False
}
