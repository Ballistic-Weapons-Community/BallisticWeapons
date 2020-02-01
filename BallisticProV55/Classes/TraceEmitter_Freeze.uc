class TraceEmitter_Freeze extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	Emitters[1].LifeTimeRange.Min = Distance / 9000;
	Emitters[1].LifeTimeRange.Max = Distance / 9000;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=FreezeBullets
         StaticMesh=StaticMesh'BallisticHardware2.Fifty9.Fifty9Tracer'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.500000,Max=0.700000))
         Opacity=0.750000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(Z=(Min=2.000000,Max=4.000000))
         StartSizeRange=(X=(Min=0.500000),Y=(Min=0.500000,Max=0.700000),Z=(Min=0.500000,Max=0.700000))
         InitialParticlesPerSecond=50000.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=9000.000000,Max=9000.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.TraceEmitter_Freeze.FreezeBullets'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.700000))
         Opacity=0.100000
         FadeOutStartTime=0.525000
         CoordinateSystem=PTCS_Relative
         MaxParticles=100
         SpinsPerSecondRange=(X=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=3.000000,Max=7.000000),Y=(Min=5.000000,Max=15.000000),Z=(Min=5.000000,Max=15.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.900000,Max=0.900000)
         StartVelocityRange=(X=(Max=9000.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.TraceEmitter_Freeze.SpriteEmitter0'

}
