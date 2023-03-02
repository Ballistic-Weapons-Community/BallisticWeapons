//=============================================================================
// IE_MetalToMetal.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_MetalToGrass extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-100.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.250000),Y=(Min=0.000000,Max=0.250000),Z=(Min=0.000000,Max=0.250000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.700000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.000000,Max=0.400000))
         FadeOutStartTime=1.480000
         FadeInEndTime=0.160000
         DetailMode=DM_SuperHigh
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.800000))
         StartSpinRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Max=0.500000),Y=(Max=0.500000),Z=(Max=0.500000))
         StartSizeRange=(X=(Min=3.000000,Max=6.000000),Y=(Min=3.000000,Max=6.000000),Z=(Min=3.000000,Max=6.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.FlamePartsAlpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Max=60.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Max=40.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_MetalToGrass.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-40.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.300000),Y=(Min=0.100000,Max=0.200000),Z=(Min=0.000000,Max=0.100000))
         Opacity=0.800000
         FadeOutStartTime=0.435000
         FadeInEndTime=0.270000
         MaxParticles=5
         AlphaRef=96
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Max=20.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Max=20.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_JWC_Pro.IE_MetalToGrass.SpriteEmitter9'

     AutoDestroy=True
}
