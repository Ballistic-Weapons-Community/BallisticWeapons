//=============================================================================
// RSNovaBladeGlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaBladeGlow extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP4-Hardware.NovaStaff.NovaBladeGlow'
         UseMeshBlendMode=False
         UseParticleColor=True
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RSNovaBladeGlow.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000))
         Opacity=0.250000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000,Z=-13.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaBladeGlow.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.250000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=45.000000,Z=-18.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSNovaBladeGlow.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.600000,Max=0.600000))
         Opacity=0.250000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=70.000000,Z=-12.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSNovaBladeGlow.SpriteEmitter3'

     bHardAttach=True
}
