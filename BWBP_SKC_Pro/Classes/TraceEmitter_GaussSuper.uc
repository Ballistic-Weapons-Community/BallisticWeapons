//=============================================================================
// TraceEmitter_GaussSuper.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_GaussSuper extends BCTraceEmitter;


simulated function Initialize(float Distance, optional float Power)
{
	BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X.Min = Distance; BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X.Max = Distance;
	BeamEmitter(Emitters[3]).BeamEndPoints[0].Offset.X = BeamEmitter(Emitters[0]).BeamEndPoints[0].Offset.X;

		Emitters[7].StartLocationRange.X.Max = FMin(2000, Distance);
		Emitters[7].SpawnOnTriggerRange.Min = FMin(120, Distance * 0.06);
		Emitters[7].SpawnOnTriggerRange.Max = Emitters[3].SpawnOnTriggerRange.Min;
	BeamEmitter(Emitters[4]).BeamDistanceRange.Min = FMax(0, Distance-100);
	BeamEmitter(Emitters[4]).BeamDistanceRange.Max = FMax(0, Distance-100);
	BeamEmitter(Emitters[6]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[6]).BeamDistanceRange.Max = Distance;
	BeamEmitter(Emitters[8]).BeamDistanceRange.Max = Distance;

}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=1200.000000,Max=1200.000000)
         BeamEndPoints(0)=(offset=(X=(Min=1000.000000,Max=1000.000000)))
         DetermineEndPointBy=PTEP_Offset
         BeamTextureUScale=2.000000
         LowFrequencyNoiseRange=(Y=(Min=-40.000000,Max=40.000000),Z=(Min=-40.000000,Max=40.000000))
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.135714,Color=(A=255))
         ColorScale(2)=(RelativeTime=0.275000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.400000,Color=(A=255))
         ColorScale(4)=(RelativeTime=0.550000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.160000
         FadeOutStartTime=0.048000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
         StartSizeRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=100.000000,Max=500.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         HighFrequencyNoiseRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
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
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000))
         Opacity=0.380000
         FadeOutStartTime=0.026000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         DetailMode=DM_SuperHigh
         StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.LightningBoltCut2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=0.500000,Max=1.010000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
     End Object
     Emitters(1)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.BeamEmitter1'

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
         FadeOutStartTime=0.064000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=20.000000)
         StartSpinRange=(X=(Min=0.260000,Max=0.260000))
         StartSizeRange=(X=(Min=3.000000,Max=10.500000),Y=(Min=3.000000,Max=10.500000),Z=(Min=3.000000,Max=10.500000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EpicParticles.Beams.BeamFalloff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=150.000000,Max=3000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.SpriteEmitter0'

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
         ColorScale(0)=(Color=(B=255,G=255,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.382143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,A=255))
         FadeOutStartTime=0.043000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Beams.HotBolt03aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.BeamEmitter3'

     Begin Object Class=BeamEmitter Name=BeamEmitter41
         BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=8.000000
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Opacity=0.250000
         FadeOutStartTime=0.192000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.180000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=0.500000)
         SizeScale(3)=(RelativeTime=1.200000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=2.000000,Max=15.000000),Y=(Min=2.000000,Max=15.000000),Z=(Min=2.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.Bulldog.BulldogSmokeCore'
         LifetimeRange=(Min=1.200000,Max=1.200000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(4)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.BeamEmitter41'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter40
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=2.000000)
         Opacity=0.100000
         FadeOutStartTime=1.000000
         FadeInEndTime=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-15.000000,Max=10.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Max=5.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.SpriteEmitter40'

     Begin Object Class=BeamEmitter Name=BeamEmitter53
         BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=16.000000
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Opacity=0.100000
         FadeOutStartTime=0.080000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=0.300000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BWBP_SKC_Tex.BeamCannon.HMCSmokeCore'
         LifetimeRange=(Min=3.500000,Max=3.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(6)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.BeamEmitter53'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter71
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.100000
         FadeOutStartTime=2.075000
         FadeInEndTime=0.175000
         CoordinateSystem=PTCS_Relative
         MaxParticles=120
         StartLocationRange=(X=(Max=1000.000000))
         StartSizeRange=(X=(Min=3.000000,Max=6.000000),Y=(Min=3.000000,Max=6.000000),Z=(Min=3.000000,Max=6.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.500000,Max=2.500000)
         SpawnOnTriggerRange=(Min=100.000000,Max=100.000000)
         SpawnOnTriggerPPS=99999.000000
         StartVelocityRange=(X=(Max=100.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.SpriteEmitter71'

     Begin Object Class=BeamEmitter Name=BeamEmitter84
         BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=16.000000
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.117857,Color=(B=255,G=255,R=128,A=255))
         ColorScale(2)=(RelativeTime=0.260714,Color=(B=160,G=160,R=160,A=255))
         ColorScale(3)=(RelativeTime=0.500000,Color=(B=255,G=192,R=128,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.900000))
         FadeOutStartTime=0.180000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BWBP_SKC_Tex.BeamCannon.HMCSmokeCore2'
         LifetimeRange=(Min=0.500000,Max=0.700000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(8)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_GaussSuper.BeamEmitter84'

}
