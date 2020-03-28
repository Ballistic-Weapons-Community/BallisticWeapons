//=============================================================================
// TraceEmitter_Supercharge! Supercharge! All call signs fire!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_Lightning extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X.Min = Distance; 
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X.Max = Distance;
	BeamEmitter(Emitters[3]).BeamEndPoints[0].Offset.X = BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X;
	BeamEmitter(Emitters[0]).BeamDistanceRange.Min = FMax(0, Distance-100);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Max = FMax(0, Distance-100);
	BeamEmitter(Emitters[3]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[3]).BeamDistanceRange.Max = Distance;
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Max=65536.000000)
         BeamEndPoints(0)=(offset=(X=(Min=65536.000000,Max=65536.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=2.000000
         LowFrequencyNoiseRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyNoiseRange=(Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         UseBranching=True
         BranchProbability=(Min=0.800000,Max=0.800000)
         BranchEmitter=1
         BranchSpawnAmountRange=(Min=1.000000,Max=1.000000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.135714,Color=(A=255))
         ColorScale(2)=(RelativeTime=0.275000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.400000,Color=(A=255))
         ColorScale(4)=(RelativeTime=0.550000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
		 ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.800000,Max=0.800000),Z=(Min=1.000000,Max=1.000000))
         Opacity=0.160000
         FadeOutStartTime=0.448000
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         SizeScale(0)=(RelativeSize=2.500000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.600000)
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'BallisticJiffyPack.TraceEmitter_Lightning.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=100.000000,Max=500.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyNoiseRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.128571,Color=(B=255,A=255))
         ColorScale(2)=(RelativeTime=0.257143,Color=(G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.382143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=0.532143,Color=(G=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.800000,Max=0.800000),Z=(Min=1.000000,Max=1.000000))
         Opacity=0.580000
         FadeOutStartTime=0.426000
         CoordinateSystem=PTCS_Relative
         MaxParticles=50
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=0.100000,Max=1.000000),Y=(Min=0.100000,Max=1.000000),Z=(Min=0.100000,Max=1.000000))
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=0.500000,Max=1.010000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(1)=BeamEmitter'BallisticJiffyPack.TraceEmitter_Lightning.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.250000,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.578571,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
		 ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.800000,Max=0.800000),Z=(Min=1.000000,Max=1.000000))
         FadeOutStartTime=0.464000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=1.000000,Max=5.500000),Y=(Min=1.000000,Max=5.500000),Z=(Min=1.000000,Max=5.500000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EpicParticles.Beams.BeamFalloff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=150.000000,Max=3000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticJiffyPack.TraceEmitter_Lightning.SpriteEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamDistanceRange=(Min=1000.000000,Max=1000.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=2.000000
         LowFrequencyNoiseRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         HighFrequencyNoiseRange=(Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.382143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,A=255))
		 ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.800000,Max=0.800000),Z=(Min=1.000000,Max=1.000000))
         FadeOutStartTime=0.443000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartSizeRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=BeamEmitter'BallisticJiffyPack.TraceEmitter_Lightning.BeamEmitter3'

}
