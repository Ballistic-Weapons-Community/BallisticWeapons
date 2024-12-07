//=============================================================================
// TraceEmitter_FIRE.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TraceEmitter_Incendiary extends BCTraceEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.TracerA1'
         UseMeshBlendMode=False
         RenderTwoSided=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorMultiplierRange=(Y=(Min=0.300000),Z=(Min=0.300000))
         Opacity=0.800000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=4.000000))
         InitialParticlesPerSecond=50000.000000
		 StartSizeRange=(Y=(Min=0.400000,Max=0.50000),Z=(Min=0.400000,Max=0.50000))
		 // offset to prevent drawing the back of the tracer through the weapon
		 StartLocationOffset=(X=100.000000,Z=-3.000000)
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=11000.000000,Max=11000.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBP_SKC_Pro.TraceEmitter_Incendiary.MeshEmitter0'

}
