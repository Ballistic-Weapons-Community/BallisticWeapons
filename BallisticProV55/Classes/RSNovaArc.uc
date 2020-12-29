//=============================================================================
// RSNovaArc.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaArc extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamEndPoints(0)=(offset=(X=(Min=18.000000,Max=18.000000)))
         DetermineEndPointBy=PTEP_Offset
         RotatingSheets=2
         LowFrequencyNoiseRange=(Y=(Min=-2.000000,Max=2.000000))
         HighFrequencyNoiseRange=(Y=(Min=-0.500000,Max=0.500000))
         HighFrequencyPoints=4
         FadeOut=True
         FadeIn=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.650000),Y=(Min=0.700000,Max=0.800000),Z=(Min=0.900000))
         FadeOutStartTime=0.064000
         FadeInEndTime=0.016000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartSizeRange=(X=(Min=2.000000,Max=20.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt01aw'
         LifetimeRange=(Min=0.100000,Max=0.150000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.RSNovaArc.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.400000),Y=(Min=0.200000,Max=0.500000),Z=(Min=0.800000))
         FadeOutStartTime=0.120000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=8.000000,Max=12.000000),Y=(Min=8.000000,Max=12.000000),Z=(Min=8.000000,Max=12.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaArc.SpriteEmitter0'

}
