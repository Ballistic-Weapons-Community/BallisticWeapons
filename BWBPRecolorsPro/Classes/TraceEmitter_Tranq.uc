//=============================================================================
// TraceEmitter_Tranq.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_Tranq extends BCTraceEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.Effects.TracerA1'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorMultiplierRange=(X=(Min=0.100000,Max=0.200000),Z=(Min=0.400000,Max=0.500000))
         Opacity=0.750000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=4.000000))
         StartSizeRange=(X=(Min=0.500000),Y=(Min=0.200000,Max=0.250000),Z=(Min=0.200000,Max=0.250000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=5000.000000,Max=5000.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBPRecolorsPro.TraceEmitter_Tranq.MeshEmitter0'

}
