//=============================================================================
// TraceEmitter_HVCBlueZap.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_HVCBlueZap extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	if (Power > 0 && Power < 1)
	{
		Emitters[0].Opacity = Power;
		Emitters[1].Opacity = Power;
		Emitters[4].Opacity = Power;
	}
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X.Min = Distance; BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X.Max = Distance;
	BeamEmitter(Emitters[4]).BeamEndPoints[0].Offset.X = BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X;
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=1200.000000,Max=1200.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=2.000000
         LowFrequencyNoiseRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyNoiseRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         UseBranching=True
         BranchProbability=(Min=0.400000,Max=0.400000)
         BranchEmitter=1
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         LowDetailFactor=1.000000
         ColorScale(0)=(Color=(B=255,G=224,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         Opacity=0.200000
         FadeOutStartTime=0.160000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.TraceEmitter_HVCBlueZap.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=100.000000,Max=300.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         LowDetailFactor=1.000000
         ColorScale(0)=(Color=(B=255,G=224,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         Opacity=0.200000
         FadeOutStartTime=0.176000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=0.500000,Max=1.010000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.TraceEmitter_HVCBlueZap.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         LowDetailFactor=1.000000
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=224,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.064000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationOffset=(X=20.000000)
         StartSpinRange=(X=(Min=0.260000,Max=0.260000))
         StartSizeRange=(X=(Min=15.000000,Max=25.500000),Y=(Min=15.000000,Max=25.500000),Z=(Min=15.000000,Max=25.500000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EpicParticles.Beams.BeamFalloff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=150.000000,Max=3000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.TraceEmitter_HVCBlueZap.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         LowDetailFactor=1.000000
         ColorScale(0)=(Color=(B=255,G=224,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.176000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.TraceEmitter_HVCBlueZap.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamDistanceRange=(Min=1000.000000,Max=1000.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=2.000000
         LowFrequencyNoiseRange=(Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyNoiseRange=(Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         LowDetailFactor=1.000000
         ColorScale(0)=(Color=(B=255,G=224,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.428571,Color=(B=255,G=192,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         Opacity=0.200000
         FadeOutStartTime=0.343000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(4)=BeamEmitter'BallisticProV55.TraceEmitter_HVCBlueZap.BeamEmitter3'

}
