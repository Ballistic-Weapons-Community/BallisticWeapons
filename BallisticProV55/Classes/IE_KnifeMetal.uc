//=============================================================================
// IE_KnifeMetal.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_KnifeMetal extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter45
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.900000),Z=(Min=0.500000,Max=0.700000))
         FadeOutStartTime=0.093000
         FadeInEndTime=0.033000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=5.000000)
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_KnifeMetal.SpriteEmitter45'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter46
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
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=64,A=255))
         ColorScale(1)=(RelativeTime=0.317857,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.532143,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000),Z=(Min=0.700000,Max=0.800000))
         FadeOutStartTime=0.063000
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=8.000000,Max=12.000000),Z=(Min=8.000000,Max=12.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         StartVelocityRange=(X=(Max=300.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Max=100.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_KnifeMetal.SpriteEmitter46'

     AutoDestroy=True
}
