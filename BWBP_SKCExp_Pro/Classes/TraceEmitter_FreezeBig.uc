class TraceEmitter_FreezeBig extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	Emitters[1].LifeTimeRange.Min = Distance / 9000;
	Emitters[1].LifeTimeRange.Max = Distance / 9000;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=FreezeBullets
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Fifty9.Fifty9Tracer'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.200000,Max=0.500000))
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
     Emitters(0)=MeshEmitter'BWBP_SKCExp_Pro.TraceEmitter_FreezeBig.FreezeBullets'

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
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.900000,Max=0.900000)
         StartVelocityRange=(X=(Max=9000.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_SKCExp_Pro.TraceEmitter_FreezeBig.SpriteEmitter0'
	 
	  Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.500000
        FadeInEndTime=0.500000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=8000.000000,Max=8000.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_SKCExp_Pro.TraceEmitter_FreezeBig.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.650000
        FadeInEndTime=0.290000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
      
        StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'BW_Core_WeaponTex.Particles.FlareA1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=8000.000000,Max=8000.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_SKCExp_Pro.TraceEmitter_FreezeBig.SpriteEmitter1'

}
