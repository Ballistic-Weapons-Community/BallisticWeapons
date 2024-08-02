//=============================================================================
// TraceEmitter_XM20Laser_P. Effects for stronger XM20 variants
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_XM20Laser_P extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	local float AdjustedPower;

	AdjustedPower = Power/255;
	AdjustedPower = 1- (0.6 * AdjustedPower);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Min = FMax(0, Distance-100);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Max = FMax(0, Distance-100);
	Emitters[0].Opacity = Emitters[0].default.Opacity * AdjustedPower;
	Emitters[1].Opacity = Emitters[1].default.Opacity * AdjustedPower;
	Emitters[3].Opacity = Emitters[3].default.Opacity * AdjustedPower;
	Emitters[5].Opacity = Emitters[5].default.Opacity * AdjustedPower;
	BeamEmitter(Emitters[1]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[1]).BeamDistanceRange.Max = Distance;
	BeamEmitter(Emitters[5]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[5]).BeamDistanceRange.Max = Distance;
	Emitters[6].LifeTimeRange.Min = Distance / 8000;
	Emitters[6].LifeTimeRange.Max = Distance / 8000;
}

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=8.000000
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         FadeOutStartTime=0.025000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         Opacity=0.75
         DetailMode=DM_SuperHigh
         StartLocationOffset=(X=100.000000)
         SizeScale(1)=(RelativeTime=0.680000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.GunFire.RailCoreWave'
         LifetimeRange=(Min=0.13000,Max=0.13000)
         StartVelocityRange=(X=(Min=0.010000,Max=0.010000))
     End Object
     Emitters(0)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser_P.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=8.000000
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=3,G=32,R=128,A=255))
         ColorScale(1)=(RelativeTime=0.275000,Color=(B=12,G=12,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.521429,Color=(R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=27,G=24,R=122,A=255))
         ColorMultiplierRange=(X=(Min=0.800000,Max=0.900000),Y=(Min=0.900000))
         FadeOutStartTime=0.192000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         Opacity=0.75
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.BeamCannon.HMCSmokeCore2'
         LifetimeRange=(Min=0.110000,Max=0.110000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser_P.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=2.000000)
         ColorScale(0)=(Color=(B=128,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=128,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.350000
         FadeOutStartTime=1.034000
         FadeInEndTime=0.396000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-15.000000,Max=10.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=5.000000,Max=20.000000),Y=(Min=5.000000,Max=20.000000),Z=(Min=5.000000,Max=20.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.BFG.PlasmaSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.50000,Max=0.50000)
         StartVelocityRange=(X=(Max=5.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser_P.SpriteEmitter2'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
         BeamDistanceRange=(Min=100.000000,Max=100.000000)
         DetermineEndPointBy=PTEP_Distance
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=128,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.025000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         Opacity=0.75
         DetailMode=DM_SuperHigh
         SizeScale(1)=(RelativeTime=0.680000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.GunFire.RailCoreWaveCap'
         LifetimeRange=(Min=0.13000,Max=0.13000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(3)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser_P.BeamEmitter3'

     Begin Object Class=SparkEmitter Name=SparkEmitter4
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.100000,Max=0.100000)
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-200.000000)
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.764286,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=128,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         FadeOutStartTime=0.530000
         CoordinateSystem=PTCS_Relative
         DetailMode=DM_SuperHigh
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.40000)
         StartVelocityRange=(X=(Min=50.000000,Max=1000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(4)=SparkEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser_P.SparkEmitter4'

     Begin Object Class=BeamEmitter Name=BeamEmitter5
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
         ColorScale(1)=(RelativeTime=0.114286,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=0.257143,Color=(B=160,G=160,R=160,A=255))
         ColorScale(3)=(RelativeTime=0.521429,Color=(R=200,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
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
         LifetimeRange=(Min=0.20000,Max=0.30000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(5)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser_P.BeamEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.700000,Max=0.800000),Y=(Min=0.100000,Max=0.200000),Z=(Min=0.800000))
         Opacity=0.530000
         FadeOutStartTime=0.525000
         CoordinateSystem=PTCS_Relative
         MaxParticles=100
         SpinsPerSecondRange=(X=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=4.500000),Y=(Min=2.000000,Max=4.500000),Z=(Min=2.000000,Max=4.500000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.BFG.PlasmaSubdivide'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.3000,Max=0.3000)
         StartVelocityRange=(X=(Max=8000.000000))
     End Object
     Emitters(6)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_XM20Laser_P.SpriteEmitter6'

}
