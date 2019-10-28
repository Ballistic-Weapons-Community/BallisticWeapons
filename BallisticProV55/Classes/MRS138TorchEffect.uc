//=============================================================================
// MRS138TorchEffect.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138TorchEffect extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=1.500000)
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.MRS138TorchEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.478571,Color=(B=128,G=128,R=128,A=128))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.900000,Max=0.900000))
         Opacity=0.350000
         FadeOutStartTime=0.520000
         FadeInEndTime=0.520000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationOffset=(X=-5.000000)
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=350.000000,Max=350.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.MRS138TorchEffect.SpriteEmitter11'

     LightSaturation=255
     LightBrightness=255.000000
     LightRadius=64.000000
     bHidden=True
     DrawScale=0.300000
     Skins(0)=Texture'BallisticEffects.Particles.FlareA1'
}
