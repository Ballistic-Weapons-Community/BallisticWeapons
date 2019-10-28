class TraceEmitter_R9Laser extends BCTraceEmitter;

simulated function Initialize(float Distance, optional float Power)
{
	BeamEmitter(Emitters[0]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[0]).BeamDistanceRange.Max = Distance;
	BeamEmitter(Emitters[1]).BeamDistanceRange.Min = Distance;
	BeamEmitter(Emitters[1]).BeamDistanceRange.Max = Distance;
	Emitters[2].LifeTimeRange.Min = Distance / 16000;
	Emitters[2].LifeTimeRange.Max = Distance / 16000;
}

	


	

defaultproperties
{
     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=16.000000
         RotatingSheets=3
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.200000,Max=0.200000))
         Opacity=0.170000
         FadeOutStartTime=0.068000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=11.000000,Max=11.000000),Y=(Min=11.000000,Max=11.000000),Z=(Min=11.000000,Max=11.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.GunFire.RailSmokeCore'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(0)=BeamEmitter'BallisticProV55.TraceEmitter_R9Laser.BeamEmitter0'

     Begin Object Class=BeamEmitter Name=BeamEmitter1
         BeamDistanceRange=(Min=5000.000000,Max=5000.000000)
         DetermineEndPointBy=PTEP_Distance
         BeamTextureUScale=16.000000
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.021000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=9.000000,Max=9.000000),Y=(Min=9.000000,Max=9.000000),Z=(Min=9.000000,Max=9.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.GunFire.RailCoreWave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.270000,Max=0.270000)
         StartVelocityRange=(X=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(1)=BeamEmitter'BallisticProV55.TraceEmitter_R9Laser.BeamEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.700000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.530000
         FadeOutStartTime=0.525000
         CoordinateSystem=PTCS_Relative
         MaxParticles=100
         SpinsPerSecondRange=(X=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=1.000000,Max=25.000000),Y=(Min=1.000000,Max=25.000000),Z=(Min=1.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.450000)
         StartVelocityRange=(X=(Max=8000.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.TraceEmitter_R9Laser.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=1,G=191,R=254,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.040000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.TraceEmitter_R9Laser.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=129,G=223,R=254,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=130,G=130,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         FadeOutStartTime=0.040000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=0.150000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=1000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.TraceEmitter_R9Laser.SpriteEmitter2'

}
