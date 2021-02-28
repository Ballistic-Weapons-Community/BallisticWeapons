//=============================================================================
// CX61's blue tracers.
//=============================================================================
class TraceEmitter_CX61Spectre extends BCTraceEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.TracerA1'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorMultiplierRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.100000,Max=0.200000))
         Opacity=0.750000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=4.000000))
         StartSizeRange=(X=(Min=0.700000),Y=(Min=0.400000,Max=0.500000),Z=(Min=0.400000,Max=0.500000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=8000.000000,Max=8000.000000))
     End Object
     Emitters(0)=MeshEmitter'BWBP_OP_Pro.TraceEmitter_CX61Spectre.MeshEmitter0'

}
