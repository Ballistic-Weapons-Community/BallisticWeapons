//=============================================================================
// RSNovaAmmoGlowA.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaAmmoGlowA extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         ZTest=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.250000,Max=0.250000))
         Opacity=0.430000
         MaxParticles=1
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=35.000000,Max=35.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSNovaAmmoGlowA.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=192,R=160,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=0.900000
         FadeInEndTime=0.450000
         StartLocationOffset=(Z=10.000000)
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.750000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Effects.Smoke7'
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Max=10.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaAmmoGlowA.SpriteEmitter2'

     CullDistance=256.000000
     bHardAttach=True
}
