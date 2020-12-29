//=============================================================================
// TraceEmitter_HVCRedMiss.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_HVCRedMiss extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	if (Power > 0 && Power < 1)
	{
		Emitters[0].Opacity = Power;
		Emitters[1].Opacity = Power;
	}
//	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X.Min = Distance;
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Max=800.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.128571,Color=(B=64,R=64,A=255))
         ColorScale(2)=(RelativeTime=0.257143,Color=(B=64,G=192,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.382143,Color=(B=64,R=64,A=255))
         ColorScale(4)=(RelativeTime=0.532143,Color=(G=128,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.176000
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=5.000000,Max=12.000000),Y=(Min=5.000000,Max=12.000000),Z=(Min=5.000000,Max=12.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.LightningBoltCut2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=0.500000,Max=1.010000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.TraceEmitter_HVCRedMiss.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=1200.000000,Max=1200.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=0.900000
         LowFrequencyNoiseRange=(Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
         HighFrequencyNoiseRange=(Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         UseBranching=True
         BranchProbability=(Min=0.400000,Max=0.400000)
         BranchEmitter=0
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
         ColorScale(5)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.160000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.LightningBoltCut2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.TraceEmitter_HVCRedMiss.BeamEmitter1'

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
         ColorScale(1)=(RelativeTime=0.250000,Color=(G=64,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.064000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=20.000000)
         StartSpinRange=(X=(Min=0.260000,Max=0.260000))
         StartSizeRange=(X=(Min=30.000000,Max=50.500000),Y=(Min=30.000000,Max=50.500000),Z=(Min=30.000000,Max=50.500000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EpicParticles.Beams.BeamFalloff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=150.000000,Max=3000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.TraceEmitter_HVCRedMiss.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=192,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.128571,Color=(B=64,G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.250000,Color=(B=192,G=192,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.414286,Color=(B=64,G=32,R=64,A=255))
         ColorScale(4)=(RelativeTime=0.560714,Color=(B=192,G=192,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.176000
         MaxParticles=1
         StartSizeRange=(X=(Min=60.000000,Max=60.000000),Y=(Min=60.000000,Max=60.000000),Z=(Min=60.000000,Max=60.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.TraceEmitter_HVCRedMiss.SpriteEmitter1'

}
