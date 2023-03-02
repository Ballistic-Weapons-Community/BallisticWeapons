//=============================================================================
// JunkTazerEffect.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkTazerEffect extends BallisticEmitter
	placeable;

var float NextCheckTime;

simulated function Tick(float DT)
{
	if (WeaponAttachment(Owner) != None && level.TimeSeconds > NextCheckTime)
	{
		if (PlayerCanSeeMe())
		{
			Emitters[1].ZTest = False;
			Emitters[5].ZTest = False;
		}
		else
		{
			Emitters[1].ZTest = True;
			Emitters[5].ZTest = True;
		}
		NextCheckTime = level.TimeSeconds + 1.0;
	}
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamEndPoints(0)=(offset=(Y=(Min=14.000000,Max=14.000000)))
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
         MaxParticles=4
         StartLocationOffset=(Y=-7.000000,Z=102.000000)
         StartLocationRange=(Z=(Min=-6.000000,Max=6.000000))
         StartSizeRange=(X=(Min=1.000000,Max=4.000000),Y=(Min=1.000000,Max=4.000000),Z=(Min=1.000000,Max=4.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.400000)
     End Object
     Emitters(0)=BeamEmitter'BWBP_JWC_Pro.JunkTazerEffect.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.800000),Y=(Min=0.800000))
         Opacity=0.330000
         FadeOutStartTime=0.030000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(Z=102.000000)
         StartLocationRange=(Z=(Min=-2.000000,Max=2.000000))
         StartSizeRange=(X=(Min=10.000000,Max=50.000000),Y=(Min=10.000000,Max=50.000000),Z=(Min=10.000000,Max=50.000000))
         Texture=Texture'BWBP_JW_Tex.Effects.HotFlareA1'
         LifetimeRange=(Min=0.100000,Max=0.300000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_JWC_Pro.JunkTazerEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.900000),Z=(Min=0.600000,Max=0.800000))
         Opacity=0.830000
         FadeOutStartTime=0.138000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(Y=-3.400000,Z=95.000000)
         StartLocationRange=(X=(Min=-0.200000,Max=0.200000),Y=(Min=-0.200000,Max=0.200000))
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         Texture=Texture'BWBP_JW_Tex.Effects.FlareB1'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(Y=(Min=-20.000000,Max=-20.000000),Z=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_JWC_Pro.JunkTazerEffect.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.800000,Max=0.900000))
         Opacity=0.830000
         FadeOutStartTime=0.138000
         FadeInEndTime=0.030000
         CoordinateSystem=PTCS_Relative
         StartLocationOffset=(Y=3.400000,Z=95.000000)
         StartLocationRange=(X=(Min=-0.200000,Max=0.200000),Y=(Min=-0.200000,Max=0.200000))
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         Texture=Texture'BWBP_JW_Tex.Effects.FlareB1'
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(Y=(Min=20.000000,Max=20.000000),Z=(Min=80.000000,Max=80.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_JWC_Pro.JunkTazerEffect.SpriteEmitter2'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.300000)
         FadeOut=True
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.800000))
         FadeOutStartTime=0.216000
         CoordinateSystem=PTCS_Relative
         MaxParticles=35
         StartLocationOffset=(Z=96.000000)
         Texture=Texture'BWBP_JW_Tex.Effects.FlareB1'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-80.000000,Max=80.000000),Z=(Min=50.000000,Max=200.000000))
     End Object
     Emitters(4)=SparkEmitter'BWBP_JWC_Pro.JunkTazerEffect.SparkEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.192857)
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,R=128))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.900000,Max=0.950000))
         Opacity=0.700000
         FadeOutStartTime=1.400000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(Z=104.000000)
         StartSizeRange=(X=(Min=80.000000),Y=(Min=80.000000),Z=(Min=80.000000))
         Texture=Texture'BWBP_JW_Tex.Effects.FlareB1'
         LifetimeRange=(Min=1.000000,Max=5.000000)
     End Object
     Emitters(5)=SpriteEmitter'BWBP_JWC_Pro.JunkTazerEffect.SpriteEmitter4'

     AutoDestroy=True
     bHidden=True
     AmbientSound=Sound'BWBP_JW_Sound.Misc.AmbientElectro'
     bHardAttach=True
     SoundRadius=32.000000
}
