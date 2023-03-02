//=============================================================================
// IE_MetalToMetal.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_MetalToWood extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(2)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-4.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
         Opacity=0.500000
         FadeOutStartTime=0.200000
         FadeInEndTime=0.200000
         MaxParticles=3
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=16.000000,Max=20.000000),Y=(Min=16.000000,Max=20.000000),Z=(Min=16.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=4.000000,Max=40.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Max=20.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_MetalToWood.SpriteEmitter4'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_JW_Static.Impact.WoodChipA1'
         UseParticleColor=True
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.250000,Max=0.700000),Y=(Min=0.250000,Max=0.700000),Z=(Min=0.250000,Max=0.700000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.540000
         FadeInEndTime=0.140000
         MaxParticles=8
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=2.000000)
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationDampingFactorRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSizeRange=(X=(Min=0.040000,Max=0.100000),Y=(Min=0.040000,Max=0.100000),Z=(Min=0.040000,Max=0.100000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=50.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-20.000000,Max=40.000000))
     End Object
     Emitters(1)=MeshEmitter'BWBP_JWC_Pro.IE_MetalToWood.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BWBP_JW_Static.Impact.WoodChipA1'
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.240000
         FadeInEndTime=0.120000
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         DetailMode=DM_High
         StartLocationOffset=(X=1.000000)
         StartLocationRange=(Y=(Min=-4.000000,Max=4.000000),Z=(Min=-6.000000,Max=6.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.050000,Max=0.150000),Y=(Min=0.050000,Max=0.150000),Z=(Min=0.050000,Max=0.150000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
     End Object
     Emitters(2)=MeshEmitter'BWBP_JWC_Pro.IE_MetalToWood.MeshEmitter1'

     AutoDestroy=True
}
