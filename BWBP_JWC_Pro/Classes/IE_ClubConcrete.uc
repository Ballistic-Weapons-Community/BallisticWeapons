//=============================================================================
// IE_ClubConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ClubConcrete extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.200000
         FadeOutStartTime=1.220000
         FadeInEndTime=0.020000
         MaxParticles=15
         StartLocationRange=(Y=(Min=-6.000000,Max=6.000000),Z=(Min=-6.000000,Max=6.000000))
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=999999.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=75.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_ClubConcrete.SpriteEmitter14'

     Begin Object Class=MeshEmitter Name=MeshEmitter6
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
         MaxParticles=7
         StartLocationOffset=(X=5.000000)
         StartLocationRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
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
     Emitters(1)=MeshEmitter'BWBP_JWC_Pro.IE_ClubConcrete.MeshEmitter6'

     AutoDestroy=True
}
