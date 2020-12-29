//=============================================================================
// HVCMk9_ClawArc.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9_ClawArc extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter2
         BeamDistanceRange=(Min=17.000000,Max=17.000000)
         BeamEndPoints(0)=(offset=(X=(Min=160.000000,Max=160.000000),Y=(Min=719.000000,Max=719.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         LowFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyNoiseRange=(X=(Min=-4.000000,Max=4.000000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         HighFrequencyPoints=8
         UseColorScale=True
         FadeOut=True
         ColorScale(0)=(Color=(B=128,G=255,A=255))
         ColorScale(1)=(RelativeTime=0.439286,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,A=255))
         FadeOutStartTime=0.022000
         MaxParticles=2
         StartLocationOffset=(X=-1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=20.000000),Y=(Min=2.000000,Max=20.000000),Z=(Min=2.000000,Max=20.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt01aw'
         LifetimeRange=(Min=0.100000,Max=0.150000)
         StartVelocityRange=(Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.HVCMk9_ClawArc.BeamEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.600000),Y=(Min=0.600000,Max=0.800000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.HVCMk9_ClawArc.SpriteEmitter5'

}
