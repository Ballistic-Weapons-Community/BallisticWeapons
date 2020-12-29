//=============================================================================
// M58Spray.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class M58Spray extends DGVEmitter;

defaultproperties
{
     bAutoAlignVelocity=True
     DisableDGV(1)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=40.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.400000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=64,R=64,A=64))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.260000
         FadeInEndTime=0.260000
         MaxParticles=80
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.120000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=80.000000,Max=120.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.M58Spray.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.VolumetricA4'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.184000
         FadeInEndTime=0.184000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-5.000000,Max=-5.000000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.200000)
         StartSizeRange=(X=(Min=0.400000,Max=0.500000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
         DrawStyle=PTDS_AlphaBlend
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.M58Spray.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=1.060000
         FadeInEndTime=0.960000
         MaxParticles=8
         StartLocationRange=(X=(Min=50.000000,Max=50.000000),Z=(Min=10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Max=0.020000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=40.000000,Max=50.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.M58Spray.SpriteEmitter1'

     AutoDestroy=True
     bHardAttach=True
}
