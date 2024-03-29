//=============================================================================
// MRS138TazerEffect.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MarlinChargeEffect extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=BeamEmitter Name=MarlinChargeEffectEmitter0
         BeamEndPoints(0)=(offset=(Y=(Min=18.000000,Max=18.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=0.500000
         HighFrequencyNoiseRange=(X=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
         HighFrequencyPoints=4
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.800000))
		 Opacity=0.400000
         FadeOutStartTime=0.084000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=8.000000,Y=-9.000000)
         StartLocationRange=(X=(Min=-2.000000,Max=2.000000))
         StartSizeRange=(X=(Min=1.000000,Max=4.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=4.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.400000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.MarlinChargeEffect.MarlinChargeEffectEmitter0'

     Begin Object Class=SpriteEmitter Name=MarlinChargeEffectEmitter2
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Z=(Min=0.800000,Max=0.900000))
         Opacity=0.100000
         FadeOutStartTime=0.058000
         FadeInEndTime=0.029000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(X=4.000000,Y=-9.500000)
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.500000,Max=1.500000),Z=(Min=-1.500000,Max=1.500000))
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.MarlinChargeEffect.MarlinChargeEffectEmitter2'

     Begin Object Class=SparkEmitter Name=MarlinChargeEffectEmitter3
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.300000)
         FadeOut=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.800000))
		 Opacity=0.200000
         FadeOutStartTime=0.216000
         CoordinateSystem=PTCS_Relative
         MaxParticles=40
         StartLocationOffset=(X=8.000000)
         StartLocationRange=(Y=(Min=-8.000000,Max=8.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.600000,Max=0.600000)
         StartVelocityRange=(X=(Min=80.000000,Max=300.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(2)=SparkEmitter'BallisticProV55.MarlinChargeEffect.MarlinChargeEffectEmitter3'

     Begin Object Class=SpriteEmitter Name=MarlinChargeEffectEmitter4
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000))
         Opacity=0.100000
         FadeOutStartTime=0.058000
         FadeInEndTime=0.029000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(X=4.000000,Y=9.500000)
         StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.500000,Max=1.500000),Z=(Min=-1.500000,Max=1.500000))
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.MarlinChargeEffect.MarlinChargeEffectEmitter4'

     AutoDestroy=True
     bHidden=True
     bHardAttach=True
}
