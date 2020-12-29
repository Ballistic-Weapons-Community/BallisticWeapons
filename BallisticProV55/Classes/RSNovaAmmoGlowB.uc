//=============================================================================
// RSNovaAmmoGlowB.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaAmmoGlowB extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.250000,Max=0.250000))
         Opacity=0.760000
         MaxParticles=1
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=37.000000,Max=37.000000),Z=(Min=52.000000,Max=52.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSNovaAmmoGlowB.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.250000,Max=0.250000))
         Opacity=0.710000
         MaxParticles=1
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=37.000000,Max=37.000000),Z=(Min=52.000000,Max=52.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaAmmoGlowB.SpriteEmitter4'

     bHardAttach=True
}
