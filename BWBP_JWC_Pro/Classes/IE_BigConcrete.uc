//=============================================================================
// IE_BigConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BigConcrete extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     DisableDGV(3)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.950000),Z=(Min=0.900000))
         Opacity=0.200000
         FadeOutStartTime=1.120000
         FadeInEndTime=0.460000
         CoordinateSystem=PTCS_Relative
         MaxParticles=35
         StartLocationOffset=(X=10.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=15.000000,Max=15.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
         InitialParticlesPerSecond=99999.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=15.000000,Max=15.000000))
         StartVelocityRadialRange=(Min=-60.000000,Max=-60.000000)
         VelocityLossRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_BigConcrete.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_JW_Static.Impact.ConcreteChip2'
         UseParticleColor=True
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.800000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.000000,Max=0.500000))
         SpawnedVelocityScaleRange=(X=(Min=100.000000,Max=100.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=3.560000
         FadeInEndTime=0.240000
         MaxParticles=15
         StartLocationOffset=(X=5.000000)
         StartLocationRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationDampingFactorRange=(X=(Max=0.800000),Y=(Max=0.800000),Z=(Max=0.800000))
         StartSizeRange=(X=(Min=0.100000,Max=0.400000),Y=(Min=0.100000,Max=0.400000),Z=(Min=0.100000,Max=0.400000))
         InitialParticlesPerSecond=100000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=250.000000
         StartVelocityRange=(X=(Min=20.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-20.000000,Max=80.000000))
     End Object
     Emitters(1)=MeshEmitter'BWBP_JWC_Pro.IE_BigConcrete.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-40.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.270000
         FadeOutStartTime=1.300000
         FadeInEndTime=0.120000
         MaxParticles=8
         StartLocationOffset=(X=5.000000)
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.750000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=8.000000,Max=15.000000),Y=(Min=8.000000,Max=15.000000),Z=(Min=8.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=50.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_JWC_Pro.IE_BigConcrete.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseDirectionAs=PTDU_Forward
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.140000
         FadeOutStartTime=0.570000
         FadeInEndTime=0.022500
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=3.000000)
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         InitialParticlesPerSecond=100000.000000
         Texture=Texture'BWBP_JW_Tex.Effects.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_JWC_Pro.IE_BigConcrete.SpriteEmitter15'

     AutoDestroy=True
}
