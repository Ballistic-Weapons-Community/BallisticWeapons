//=============================================================================
// G5LaserDot.
//
// A green dot positioned at the end of a laser
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class G5LaserDot extends BallisticEmitter
	placeable;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.800000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.025000
         FadeInEndTime=0.006000
         MaxParticles=8
         StartSizeRange=(X=(Min=1.000000,Max=4.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=4.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.100000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.G5LaserDot.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.800000),Z=(Min=0.200000,Max=0.200000))
         FadeOutStartTime=0.025000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSizeRange=(X=(Min=1.000000,Max=4.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=4.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.050000,Max=0.100000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.G5LaserDot.SpriteEmitter10'

     bHidden=True
}
