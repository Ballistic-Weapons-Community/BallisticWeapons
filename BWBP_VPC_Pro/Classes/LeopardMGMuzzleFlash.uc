//=============================================================================
// The emitter for the Leopard MG's muzzle flash.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class LeopardMGMuzzleFlash extends Emitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         Opacity=0.250000
         FadeOutStartTime=3.000000
         MaxParticles=2
         DetailMode=DM_High
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.LeopardMGMuzzleFlash.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-40.000000)
         ColorScale(0)=(Color=(B=128,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         Opacity=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         DetailMode=DM_High
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         StartSizeRange=(X=(Min=0.500000,Max=2.000000),Y=(Min=0.500000,Max=2.000000),Z=(Min=0.500000,Max=2.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'EpicParticles.Flares.Sharpstreaks2'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         StartVelocityRange=(X=(Min=3.000000,Max=30.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=50.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.LeopardMGMuzzleFlash.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'XEffects.MinigunFlashMesh'
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutoDestroy=True
         UniformMeshScale=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=128,G=192,R=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.800000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=3.000000))
         StartSizeRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.200000,Max=0.300000),Z=(Min=0.200000,Max=0.300000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_Brighten
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=-6.000000,Max=6.000000))
     End Object
     Emitters(2)=MeshEmitter'BWBP_VPC_Pro.LeopardMGMuzzleFlash.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'VMmeshEmitted.EJECTA.EjectedBRASSsm'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-26.000000,Max=-26.000000),Y=(Min=-8.000000,Max=-8.000000),Z=(Min=2.000000,Max=2.000000))
         SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=5.000000))
         RotationDampingFactorRange=(X=(Max=0.800000),Y=(Max=0.800000),Z=(Max=0.800000))
         StartSizeRange=(X=(Min=0.025000,Max=0.025000),Y=(Min=0.025000,Max=0.025000),Z=(Min=0.025000,Max=0.025000))
         InitialParticlesPerSecond=4.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-80.000000,Max=-50.000000),Z=(Min=-10.000000,Max=50.000000))
     End Object
     Emitters(3)=MeshEmitter'BWBP_VPC_Pro.LeopardMGMuzzleFlash.MeshEmitter1'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'BWBP_Vehicles_Static.Effects.BulletLink'
         UseCollision=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-26.000000,Max=-26.000000),Y=(Min=-8.000000,Max=-8.000000),Z=(Min=2.000000,Max=2.000000))
         SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=5.000000))
         RotationDampingFactorRange=(X=(Max=0.800000),Y=(Max=0.800000),Z=(Max=0.800000))
         StartSizeRange=(X=(Min=0.150000,Max=0.150000),Y=(Min=0.150000,Max=0.150000),Z=(Min=0.150000,Max=0.150000))
         InitialParticlesPerSecond=4.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-80.000000,Max=-50.000000),Z=(Min=-10.000000,Max=50.000000))
     End Object
     Emitters(4)=MeshEmitter'BWBP_VPC_Pro.LeopardMGMuzzleFlash.MeshEmitter2'

     AutoDestroy=True
     CullDistance=4000.000000
     bNoDelete=False
     bHardAttach=True
}
