//=============================================================================
// TraceEmitter_Bulldog. Effects for the AC.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_Bulldog extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	BeamEmitter(Emitters[0]).BeamDistanceRange.Min = FMax(0, Distance-100);
	BeamEmitter(Emitters[0]).BeamDistanceRange.Max = FMax(0, Distance-100);
	BeamEmitter(Emitters[2]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[2]).BeamDistanceRange.Max = Distance;
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
         Opacity=0.800000
         FadeOutStartTime=0.192000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=-30.000000)
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.180000,RelativeSize=0.300000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=0.500000)
         SizeScale(3)=(RelativeTime=1.200000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticRecolors3TexPro.Bulldog.BulldogSmokeCore'
         LifetimeRange=(Min=1.200000,Max=1.200000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'BWBPRecolorsPro.TraceEmitter_Bulldog.BeamEmitter1'

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
         StartLocationOffset=(X=-30.000000)
         StartLocationRange=(X=(Min=-15.000000,Max=10.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.300000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Max=5.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.TraceEmitter_Bulldog.SpriteEmitter0'

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
         StartLocationOffset=(X=-30.000000)
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.300000,RelativeSize=0.300000)
         StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticRecolors3TexPro.Bulldog.BulldogSmokeCore'
         LifetimeRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=BeamEmitter'BWBPRecolorsPro.TraceEmitter_Bulldog.BeamEmitter3'

}
