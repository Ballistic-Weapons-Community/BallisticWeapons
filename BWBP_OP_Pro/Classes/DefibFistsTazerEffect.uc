//=============================================================================
// MRS138TazerEffect.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DefibFistsTazerEffect extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamEndPoints(0)=(offset=(Y=(Min=-9.000000,Max=-9.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=0.500000
         HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         HighFrequencyPoints=4
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.800000))
         FadeOutStartTime=0.084000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-2.000000,Max=1.000000))
         StartSizeRange=(X=(Min=1.000000,Max=4.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=4.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.400000)
     End Object
     Emitters(0)=BeamEmitter'BWBP_OP_Pro.DefibFistsTazerEffect.BeamEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.800000))
         Opacity=0.300000
         FadeOutStartTime=0.030000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-8.000000,Max=8.000000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_OP_Pro.DefibFistsTazerEffect.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Z=(Min=0.800000,Max=0.900000))
         Opacity=0.430000
         FadeOutStartTime=0.058000
         FadeInEndTime=0.029000
         CoordinateSystem=PTCS_Relative
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_OP_Pro.DefibFistsTazerEffect.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000))
         Opacity=0.430000
         FadeOutStartTime=0.058000
         FadeInEndTime=0.029000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(Y=-6.000000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_OP_Pro.DefibFistsTazerEffect.SpriteEmitter4'

     AutoDestroy=True
     bHardAttach=True
}
