class TraceEmitter_BX85Crossbow extends BCTraceEmitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=CrossbowBoltEmitter
		 StaticMesh=StaticMesh'BW_Core_WeaponStatic.OA-SMG.OA-SMG_Dart'
         UseMeshBlendMode=False
         RenderTwoSided=True
		 DrawStyle=PTDS_Regular
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         Opacity=1
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
		 AlphaTest=False
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=4.000000))
         StartSizeRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.50000),Z=(Min=0.500000,Max=0.50000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=15000.000000,Max=15000.000000))
     End Object
     Emitters(0)=MeshEmitter'CrossbowBoltEmitter'

}