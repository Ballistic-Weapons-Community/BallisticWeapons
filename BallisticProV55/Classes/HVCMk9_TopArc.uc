//=============================================================================
// HVCMk9_TopArc.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9_TopArc extends BallisticEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	if (WeaponAttachment(Owner) != None)
//	{
		Emitters[0].ZTest = true;
//		Emitters[2].ZTest = true;
//	}
}

simulated function SetColorShift(float Alpha)
{
	Emitters[0].ColorMultiplierRange.X.Min = Lerp(Alpha, 0.4, 1.0); 	Emitters[0].ColorMultiplierRange.X.Max = Emitters[0].ColorMultiplierRange.X.Min;
//	Emitters[0].ColorMultiplierRange.Y.Min = Lerp(Alpha, 0.4, 0.4); 	Emitters[0].ColorMultiplierRange.Y.Max = Emitters[0].ColorMultiplierRange.Y.Min;
	Emitters[0].ColorMultiplierRange.Z.Min = Lerp(Alpha, 0.4, 0.0); 	Emitters[0].ColorMultiplierRange.Z.Max = Emitters[0].ColorMultiplierRange.Z.Min;
//	Emitters[1].ColorMultiplierRange.X.Min = Lerp(Alpha, 1.0, 1.0); 	Emitters[1].ColorMultiplierRange.X.Max = Emitters[1].ColorMultiplierRange.X.Min;
	Emitters[1].ColorMultiplierRange.Y.Min = Lerp(Alpha, 1.0, 0.8); 	Emitters[1].ColorMultiplierRange.Y.Max = Emitters[1].ColorMultiplierRange.Y.Min;
	Emitters[1].ColorMultiplierRange.Z.Min = Lerp(Alpha, 1.0, 0.7); 	Emitters[1].ColorMultiplierRange.Z.Max = Emitters[1].ColorMultiplierRange.Z.Min;
	Emitters[2].ColorMultiplierRange.X.Min = Lerp(Alpha, 0.1, 1.0); 	Emitters[2].ColorMultiplierRange.X.Max = Emitters[2].ColorMultiplierRange.X.Min;
	Emitters[2].ColorMultiplierRange.Y.Min = Lerp(Alpha, 0.2, 0.1); 	Emitters[2].ColorMultiplierRange.Y.Max = Emitters[2].ColorMultiplierRange.Y.Min;
	Emitters[2].ColorMultiplierRange.Z.Min = Lerp(Alpha, 1.0, 0.1); 	Emitters[2].ColorMultiplierRange.Z.Max = Emitters[2].ColorMultiplierRange.Z.Min;
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
         FadeOutStartTime=0.044000
         FadeInEndTime=0.038000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_SuperHigh
         StartLocationOffset=(Z=8.000000)
         StartLocationRange=(Z=(Min=-4.000000,Max=4.000000))
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.080000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.HVCMk9_TopArc.SpriteEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=17.000000,Max=17.000000)
         BeamEndPoints(0)=(offset=(Z=(Min=18.000000,Max=18.000000)),Weight=1.000000)
         DetermineEndPointBy=PTEP_Offset
         LowFrequencyNoiseRange=(X=(Min=-4.000000,Max=4.000000),Y=(Min=-4.000000,Max=4.000000))
         HighFrequencyPoints=3
         FadeOut=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.022000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=20.000000),Y=(Min=2.000000,Max=20.000000),Z=(Min=2.000000,Max=20.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt01aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.HVCMk9_TopArc.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.600000,Max=0.600000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(Z=8.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.HVCMk9_TopArc.SpriteEmitter1'

}
