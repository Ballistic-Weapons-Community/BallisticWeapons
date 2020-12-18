//=============================================================================
// LAWLaserBlast.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class LAWLaserBlast extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.100000,Max=0.300000))
         FadeOutStartTime=0.025000
         FadeInEndTime=0.006000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=0.300000)
         StartSizeRange=(X=(Min=1.700000,Max=2.100000),Y=(Min=1.700000,Max=2.100000),Z=(Min=1.700000,Max=2.100000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.LAWLaserBlast.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.100000,Max=0.300000))
         Opacity=0.460000
         FadeOutStartTime=0.128000
         FadeInEndTime=0.128000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=2.000000)
         StartSizeRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
         Texture=Texture'BallisticEffects.Particles.WaterSpray1'
         LifetimeRange=(Min=0.200000,Max=0.500000)
         StartVelocityRange=(X=(Min=0.010000,Max=0.010000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.LAWLaserBlast.SpriteEmitter9'

     bHidden=True
}
