//=============================================================================
// TraceEmitter_M30Gauss. Effects for the gauss shot.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_M30Gauss extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
		Emitters[3].StartLocationRange.X.Max = FMin(2000, Distance);
		Emitters[3].SpawnOnTriggerRange.Min = FMin(120, Distance * 0.06);
		Emitters[3].SpawnOnTriggerRange.Max = Emitters[3].SpawnOnTriggerRange.Min;
//		Trigger(Owner, None);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Min = FMax(0, Distance-100);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Max = FMax(0, Distance-100);
	BeamEmitter(Emitters[2]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[2]).BeamDistanceRange.Max = Distance;
	BeamEmitter(Emitters[4]).BeamDistanceRange.Max = Distance;

/*	BeamEmitter(Emitters[5]).BeamDistanceRange.Min = FMax(0, Distance-100);
	BeamEmitter(Emitters[5]).BeamDistanceRange.Max = FMax(0, Distance-100);
	BeamEmitter(Emitters[6]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[6]).BeamDistanceRange.Max = Distance;
	BeamEmitter(Emitters[10]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[10]).BeamDistanceRange.Max = Distance; */
}

defaultproperties
{
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
     Emitters(0)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_M30Gauss.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
     Emitters(1)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_M30Gauss.SpriteEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter3
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
     Emitters(2)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_M30Gauss.BeamEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
     Emitters(3)=SpriteEmitter'BWBP_SKC_Pro.TraceEmitter_M30Gauss.SpriteEmitter1'

     Begin Object Class=BeamEmitter Name=BeamEmitter4
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
     Emitters(4)=BeamEmitter'BWBP_SKC_Pro.TraceEmitter_M30Gauss.BeamEmitter4'

}
