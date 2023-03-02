//=============================================================================
// IE_BigGrass.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_BigGrass extends DGVEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-150.000000)
         DampingFactorRange=(X=(Min=0.400000,Max=0.600000),Y=(Min=0.400000,Max=0.600000),Z=(Min=0.400000,Max=0.600000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.300000,Max=0.800000),Y=(Min=0.500000),Z=(Min=0.200000,Max=0.300000))
         FadeOutStartTime=0.620000
         FadeInEndTime=0.030000
         MaxParticles=6
         StartLocationRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         AlphaRef=140
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=8.000000,Max=16.000000),Y=(Min=8.000000,Max=16.000000),Z=(Min=8.000000,Max=16.000000))
         InitialParticlesPerSecond=500000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=5.000000,Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_JWC_Pro.IE_BigGrass.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-75.000000)
         ColorScale(0)=(Color=(B=10,G=60,R=60,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=10,G=60,R=60,A=255))
         FadeOutStartTime=0.570000
         FadeInEndTime=0.030000
         MaxParticles=4
         StartLocationRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         AlphaRef=96
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=15.000000,Max=22.000000),Y=(Min=15.000000,Max=22.000000),Z=(Min=15.000000,Max=22.000000))
         InitialParticlesPerSecond=5000000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=25.000000,Max=100.000000),Y=(Min=-35.000000,Max=35.000000),Z=(Min=-35.000000,Max=35.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_JWC_Pro.IE_BigGrass.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-35.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.550000,Max=0.650000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.200000,Max=0.300000))
         Opacity=0.280000
         FadeOutStartTime=1.320000
         FadeInEndTime=0.080000
         MaxParticles=6
         StartLocationRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=99999.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BWBP_JW_Tex.Effects.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=25.000000,Max=75.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_JWC_Pro.IE_BigGrass.SpriteEmitter4'

     AutoDestroy=True
}
