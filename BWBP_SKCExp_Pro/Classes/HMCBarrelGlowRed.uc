//=============================================================================
// HVCMk9RedMuzzleFlash.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HMCBarrelGlowRed extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamEndPoints(0)=(offset=(X=(Min=-80.000000,Max=-80.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=0.500000
         HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         HighFrequencyPoints=4
         UseColorScale=True
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.914286,Color=(A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000),Z=(Min=0.100000,Max=0.200000))
         FadeOutStartTime=0.080000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartSizeRange=(X=(Min=4.000000,Max=14.000000),Y=(Min=4.000000,Max=14.000000),Z=(Min=4.000000,Max=14.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.501000,Max=0.501000)
     End Object
     Emitters(0)=BeamEmitter'BWBP_SKCExp_Pro.HMCBarrelGlowRed.BeamEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.000000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.300000
         FadeOutStartTime=0.030000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=8.000000)
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-8.000000,Max=8.000000))
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKCExp_Pro.HMCBarrelGlowRed.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000),Y=(Min=0.000000,Max=0.400000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.830000
         FadeOutStartTime=0.058000
         FadeInEndTime=0.029000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(X=-5.000000)
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.500000,Max=1.500000),Z=(Min=-1.500000,Max=1.500000))
         StartSizeRange=(X=(Min=1.000000,Max=10.000000),Y=(Min=1.000000,Max=10.000000),Z=(Min=1.000000,Max=10.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaBubbleA1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKCExp_Pro.HMCBarrelGlowRed.SpriteEmitter10'

     Begin Object Class=SparkEmitter Name=SparkEmitter2
         LineSegmentsRange=(Min=2.000000,Max=2.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.300000)
         UseColorScale=True
         FadeOut=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(R=255,A=255))
         ColorScale(1)=(RelativeTime=0.250000,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.000000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.216000
         CoordinateSystem=PTCS_Relative
         MaxParticles=80
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(3)=SparkEmitter'BWBP_SKCExp_Pro.HMCBarrelGlowRed.SparkEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.000000,Max=0.600000),Z=(Min=0.000000,Max=0.200000))
         Opacity=0.830000
         FadeOutStartTime=0.058000
         FadeInEndTime=0.029000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(X=-80.000000)
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.500000,Max=1.500000),Z=(Min=-1.500000,Max=1.500000))
         StartSizeRange=(X=(Min=1.000000,Max=12.000000),Y=(Min=1.000000,Max=12.000000),Z=(Min=1.000000,Max=12.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_SKCExp_Pro.HMCBarrelGlowRed.SpriteEmitter4'

}
