//=============================================================================
// RSDarkRampageGlow.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkRampageGlow extends BallisticEmitter;

function InvertY()
{
	local int i;
	for (i=0;i<Emitters.length;i++)
	{
		Emitters[i].StartLocationOffset.Y *= -1;
	}
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(R=16,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=16,A=255))
         FadeOutStartTime=0.054000
         FadeInEndTime=0.005000
         CoordinateSystem=PTCS_Relative
         MaxParticles=50
         StartLocationOffset=(X=-35.000000)
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=1750.000000,Max=1750.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDarkRampageGlow.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=100,G=100,R=160,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         FadeOutStartTime=0.360000
         FadeInEndTime=0.140000
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         StartLocationOffset=(Z=15.000000)
         StartLocationRange=(X=(Min=-20.000000,Max=55.000000))
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=20.000000,Max=35.000000),Z=(Min=10.000000,Max=10.000000))
         Texture=Texture'BallisticEffects.Particles.BlazingSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Max=15.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkRampageGlow.SpriteEmitter10'

     bHardAttach=True
}
