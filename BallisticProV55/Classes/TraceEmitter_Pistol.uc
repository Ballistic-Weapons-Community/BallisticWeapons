//=============================================================================
// TraceEmitter_Pistol.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_Pistol extends BCTraceEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BallisticHardware2.Effects.TracerA1'
         UseMeshBlendMode=False
         RenderTwoSided=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.300000),Z=(Min=0.300000))
         Opacity=0.750000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=4.000000))
         StartSizeRange=(X=(Min=0.300000,Max=0.500000),Y=(Min=0.150000,Max=0.150000),Z=(Min=0.150000,Max=0.150000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=8000.000000,Max=8000.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.TraceEmitter_Pistol.MeshEmitter0'

}
