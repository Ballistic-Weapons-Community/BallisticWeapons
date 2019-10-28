//-----------------------------------------------------------
//
//-----------------------------------------------------------
class X93Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter51
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=20
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.OutSpark02aw'
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-1600.000000,Max=1600.000000),Y=(Min=-1600.000000,Max=1600.000000),Z=(Min=2000.000000,Max=3000.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter51'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter52
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=100.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=150,A=255))
         Opacity=0.500000
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         MaxParticles=50
         StartLocationRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Smoke.Smokepuff'
         LifetimeRange=(Min=8.000000,Max=8.000000)
         StartVelocityRange=(X=(Min=-2500.000000,Max=2500.000000),Y=(Min=-2500.000000,Max=2500.000000),Z=(Max=2500.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=0.750000,Max=0.750000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter52'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter53
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         MaxParticles=1
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter53'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter54
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         MaxParticles=1
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter54'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter56
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=150,A=255))
         Opacity=0.750000
         MaxParticles=2
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter56'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter57
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         MaxParticles=50
         StartLocationOffset=(Z=500.000000)
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.OutSpark02aw'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-4500.000000,Max=4500.000000),Y=(Min=-4500.000000,Max=4500.000000),Z=(Max=4500.000000))
         VelocityLossRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.750000,Max=0.750000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter57'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter55
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=150,A=255))
         MaxParticles=1
         StartSizeRange=(X=(Min=5000.000000,Max=5000.000000),Y=(Min=5000.000000,Max=5000.000000),Z=(Min=5000.000000,Max=5000.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter55'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter58
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         VelocityFromMesh=True
         UniformMeshScale=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=150,A=255))
         MaxParticles=150
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=2000.000000,Max=2000.000000))
         MeshScaleRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Smoke.Smokepuff'
         LifetimeRange=(Min=1.500000,Max=2.000000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter58'

     Begin Object Class=BeamEmitter Name=BeamEmitter2
         BeamDistanceRange=(Min=100000.000000,Max=100000.000000)
         DetermineEndPointBy=PTEP_Distance
         RotatingSheets=2
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=200,A=255))
         FadeOutStartTime=0.500000
         MaxParticles=1
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'VMParticleTextures.LeviathanParticleEffects.LEVmainPartBeam'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=100.000000,Max=100.000000))
     End Object
     Emitters(8)=BeamEmitter'BWBPAirstrikesPro.X93Explosion.BeamEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=150,A=255))
         FadeOutStartTime=0.300000
         MaxParticles=1
         SpinsPerSecondRange=(Y=(Min=0.500000,Max=1.000000),Z=(Min=0.500000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=500.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'VMmeshEmitted.EJECTA.Sphere'
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(10)=MeshEmitter'BWBPAirstrikesPro.X93Explosion.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=50
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'VMParticleTextures.PowerNodeEXP.powerNodeEXPblueTEX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.500000)
         StartVelocityRange=(X=(Min=-1600.000000,Max=1600.000000),Y=(Min=-1600.000000,Max=1600.000000),Z=(Max=100.000000))
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.X93Explosion.SpriteEmitter1'

     Begin Object Class=SparkEmitter Name=SparkEmitter0
         LineSegmentsRange=(Min=1.000000,Max=1.000000)
         TimeBetweenSegmentsRange=(Min=0.200000,Max=0.200000)
         FadeOut=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         MaxParticles=50
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'VMParticleTextures.VEHICLEtrailsGROUP.JetExhaustORANGEtex'
         InitialDelayRange=(Max=0.500000)
         StartVelocityRange=(X=(Min=-1500.000000,Max=1500.000000),Y=(Min=-1500.000000,Max=1500.000000),Z=(Min=3500.000000,Max=4500.000000))
     End Object
     Emitters(12)=SparkEmitter'BWBPAirstrikesPro.X93Explosion.SparkEmitter0'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
