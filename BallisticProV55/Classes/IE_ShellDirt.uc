//=============================================================================
// IE_ShellDirt.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_ShellDirt extends DGVEmitter
	placeable;

defaultproperties
{
     DisableDGV(0)=1
     Begin Object Class=MeshEmitter Name=MeshEmitter13
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.VolumetricA3'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=64,G=96,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=96,R=128,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.500000,Max=0.500000))
         FadeOutFactor=(X=1.500000,Y=1.200000)
         FadeOutStartTime=0.432000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.370000,RelativeSize=1.800000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=2.500000)
         StartSizeRange=(X=(Min=0.300000,Max=0.400000),Y=(Min=0.600000,Max=0.800000),Z=(Min=0.600000,Max=0.800000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.200000,Max=1.200000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.IE_ShellDirt.MeshEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter41
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=64,G=96,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=96,R=128,A=255))
         Opacity=0.830000
         FadeOutFactor=(X=1.500000,Y=1.200000)
         FadeOutStartTime=1.360000
         FadeInEndTime=0.060000
         MaxParticles=4
         StartLocationOffset=(X=10.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=0.400000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=20.000000,Max=40.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.IE_ShellDirt.SpriteEmitter41'

     AutoDestroy=True
}
