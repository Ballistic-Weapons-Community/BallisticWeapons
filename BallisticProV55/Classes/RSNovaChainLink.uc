//=============================================================================
// RSNovaChainLink.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaChainLink extends BallisticEmitter;

simulated function SetPoints(vector Start, vector End)
{
	Emitters[0].StartLocationOffset = Start;
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset = VToRV(End, End);
	Emitters[1].StartLocationOffset = Start;
	Emitters[2].StartLocationOffset = End;
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamEndPoints(0)=(offset=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000)))
         DetermineEndPointBy=PTEP_OffsetAsAbsolute
         BeamTextureUScale=4.000000
         RotatingSheets=2
         LowFrequencyNoiseRange=(X=(Min=-25.000000,Max=25.000000),Y=(Min=-25.000000,Max=25.000000),Z=(Min=-25.000000,Max=25.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=192,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.171429,Color=(A=255))
         ColorScale(2)=(RelativeTime=0.317857,Color=(B=255,G=200,R=128,A=255))
         ColorScale(3)=(RelativeTime=0.414286,Color=(A=255))
         ColorScale(4)=(RelativeTime=0.600000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.160000
         FadeInEndTime=0.045000
         CoordinateSystem=PTCS_Absolute
         MaxParticles=2
         StartLocationOffset=(X=512.000000)
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.750000)
         StartSizeRange=(X=(Min=40.000000,Max=80.000000),Y=(Min=40.000000,Max=80.000000),Z=(Min=40.000000,Max=80.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt01aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.RSNovaChainLink.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=192,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=192,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000),Y=(Min=0.850000),Z=(Min=0.900000))
         FadeOutStartTime=0.038000
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Absolute
         MaxParticles=1
         StartLocationOffset=(X=-560.830017,Y=245.740997,Z=-324.306000)
         StartSizeRange=(X=(Min=50.000000,Max=75.000000),Y=(Min=50.000000,Max=75.000000),Z=(Min=50.000000,Max=75.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNovaChainLink.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=192,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=192,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000),Y=(Min=0.850000),Z=(Min=0.900000))
         FadeOutStartTime=0.038000
         FadeInEndTime=0.010000
         CoordinateSystem=PTCS_Absolute
         MaxParticles=1
         StartLocationOffset=(X=-50.000000,Y=245.740997,Z=-324.306000)
         StartSizeRange=(X=(Min=65.000000,Max=85.000000),Y=(Min=65.000000,Max=85.000000),Z=(Min=65.000000,Max=85.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSNovaChainLink.SpriteEmitter2'

}
