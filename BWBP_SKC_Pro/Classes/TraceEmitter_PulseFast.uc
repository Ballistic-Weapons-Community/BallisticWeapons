//=============================================================================
// TraceEmitter_PulseFast. Faster and cooler
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_PulseFast extends BCTraceEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_SKC_Static.LaserCarbine.TracerA3'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Opacity=3.250000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=4.000000))
         StartSizeRange=(X=(Min=0.700000),Y=(Min=0.300000,Max=0.450000),Z=(Min=0.300000,Max=0.450000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=18000.000000,Max=18000.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBP_SKC_Pro.TraceEmitter_PulseFast.MeshEmitter0'

}
