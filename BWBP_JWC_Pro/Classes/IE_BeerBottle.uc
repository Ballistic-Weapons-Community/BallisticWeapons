//=============================================================================
// IE_BeerBottle.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BeerBottle extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_JW_Static.Effects.BottleShard'
         RenderTwoSided=True
         UseParticleColor=True
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.400000),Y=(Min=0.400000),Z=(Min=0.200000,Max=0.800000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.500000),Y=(Min=0.900000),Z=(Min=0.200000,Max=0.400000))
         FadeOutStartTime=1.560000
         MaxParticles=30
         StartLocationOffset=(X=1.000000)
         StartLocationRange=(X=(Max=4.000000))
         SpinsPerSecondRange=(X=(Max=3.000000),Y=(Max=3.000000),Z=(Max=3.000000))
         StartSpinRange=(Z=(Max=1.000000))
         RotationDampingFactorRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.050000,Max=0.300000),Y=(Min=0.050000,Max=0.300000),Z=(Min=0.050000,Max=0.300000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=250.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=100.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-20.000000,Max=80.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBP_JWC_Pro.IE_BeerBottle.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.400000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.000000,Max=0.200000))
         FadeOutStartTime=0.150000
         MaxParticles=2
         StartLocationOffset=(X=4.000000)
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=6.000000,Max=60.000000),Y=(Min=6.000000,Max=60.000000),Z=(Min=6.000000,Max=60.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_JWC_Pro.IE_BeerBottle.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-200.000000)
         DampingFactorRange=(X=(Min=0.500000),Y=(Min=0.500000),Z=(Min=0.000000,Max=0.800000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.500000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=1.560000
         MaxParticles=20
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.FlamePartsAlpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=250.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-20.000000,Max=80.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_JWC_Pro.IE_BeerBottle.SpriteEmitter1'

     AutoDestroy=True
}
