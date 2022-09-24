//=============================================================================
// RSNova_FreeChainZap.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNova_FreeChainZap extends BallisticEmitter;
/*
event PostBeginPlay()
{
	super.PostBeginPlay();
	settimer (0.1,true);
}
event Timer()
{
	local vector End, X,Y,Z;

	GetAxes(Rotation, X,Y,Z);
	End = X * 4;
	BeamEmitter(Emitters[1]).StartVelocityRange = VtoRV(End, End);
	BeamEmitter(Emitters[1]).StartVelocityRange.X.Min -= 2 * Abs(X.Z);
	BeamEmitter(Emitters[1]).StartVelocityRange.X.Max += 2 * Abs(X.Z);
	BeamEmitter(Emitters[1]).StartVelocityRange.Y.Min -= 2 * Abs(X.X);
	BeamEmitter(Emitters[1]).StartVelocityRange.Y.Max += 2 * Abs(X.X);
	BeamEmitter(Emitters[1]).StartVelocityRange.Z.Min -= 2 * (1-Abs(X.Z));
	BeamEmitter(Emitters[1]).StartVelocityRange.Z.Max += 2 * (1-Abs(X.Z));

	BeamEmitter(Emitters[3]).StartVelocityRange = BeamEmitter(Emitters[1]).StartVelocityRange;
}
*/

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter1
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=0.800000
         RotatingSheets=2
         LowFrequencyNoiseRange=(X=(Min=50.000000,Max=100.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         LowFrequencyPoints=5
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=96,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.132500
         FadeInEndTime=0.027500
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.250000)
         StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
         Texture=Texture'BallisticEpicEffects.Beams.HotBolt02aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.RSNova_FreeChainZap.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.076500
         FadeInEndTime=0.019500
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=35.000000,Max=40.000000),Y=(Min=35.000000,Max=40.000000),Z=(Min=35.000000,Max=40.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.150000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSNova_FreeChainZap.SpriteEmitter3'

     Begin Object Class=BeamEmitter Name=BeamEmitter2
         BeamDistanceRange=(Min=128.000000,Max=512.000000)
         LowFrequencyNoiseRange=(X=(Min=150.000000,Max=250.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
         HighFrequencyNoiseRange=(X=(Min=-4.000000,Max=4.000000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         HighFrequencyPoints=8
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=128,A=255))
         ColorScale(1)=(RelativeTime=0.242857,Color=(A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=255,G=192,R=128,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.320000
         FadeInEndTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SphereRadiusRange=(Min=24.000000,Max=24.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.250000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=35.000000),Y=(Min=15.000000,Max=35.000000),Z=(Min=15.000000,Max=35.000000))
         InitialParticlesPerSecond=5.000000
         Texture=Texture'BallisticEpicEffects.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRadialRange=(Min=-1.000000,Max=-1.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=BeamEmitter'BallisticProV55.RSNova_FreeChainZap.BeamEmitter2'

}
