//-----------------------------------------------------------
//
//-----------------------------------------------------------
class FAEClusterExplosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.907143,Color=(B=225,G=225,R=225,A=160))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutStartTime=0.686190
         DetailMode=DM_High
         StartLocationOffset=(Z=200.000000)
         StartLocationRange=(X=(Min=-160.000000,Max=160.000000),Y=(Min=-160.000000,Max=160.000000),Z=(Min=-200.000000,Max=600.000000))
         AddLocationFromOtherEmitter=4
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=900.000000,Max=1000.000000),Y=(Min=900.000000,Max=1000.000000),Z=(Min=900.000000,Max=1000.000000))
         InitialParticlesPerSecond=80.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=8.000000,Max=200.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.700000
         FadeOutStartTime=0.119000
         MaxParticles=6
         StartLocationRange=(Z=(Min=1.000000,Max=1.000000))
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=480.000000,Max=480.000000),Y=(Min=480.000000,Max=480.000000),Z=(Min=480.000000,Max=480.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.500000,Max=1.500000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.907143,Color=(B=225,G=225,R=225,A=160))
         ColorScale(2)=(RelativeTime=1.000000)
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(4)=(RelativeTime=1.000000)
         FadeOutStartTime=0.686190
         DetailMode=DM_High
         StartLocationOffset=(Z=200.000000)
         StartLocationRange=(X=(Min=-160.000000,Max=160.000000),Y=(Min=-160.000000,Max=160.000000),Z=(Min=-200.000000,Max=600.000000))
         AddLocationFromOtherEmitter=4
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=900.000000,Max=1000.000000),Y=(Min=900.000000,Max=1000.000000),Z=(Min=900.000000,Max=1000.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=8.000000,Max=200.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=255,R=255,A=255))
         MaxParticles=5
         AddLocationFromOtherEmitter=2
         SizeScale(0)=(RelativeSize=5.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         AddVelocityFromOtherEmitter=2
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
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
         MaxParticles=25
         StartLocationOffset=(Z=1500.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         LifetimeRange=(Min=1.250000,Max=1.250000)
         StartVelocityRange=(X=(Min=-1500.000000,Max=1500.000000),Y=(Min=-1500.000000,Max=1500.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter19'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.300000
         FadeOutStartTime=7.350000
         FadeInEndTime=1.950000
         MaxParticles=50
         StartLocationRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000))
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(Z=(Min=150.000000,Max=150.000000))
         VelocityLossRange=(Z=(Min=0.250000,Max=0.250000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-425.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(G=150,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=100,R=150,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=20
         StartLocationOffset=(Z=1500.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         LifetimeRange=(Min=5.000000,Max=5.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Max=1000.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         MaxParticles=20
         StartLocationRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=-400.000000,Max=400.000000))
         AddLocationFromOtherEmitter=4
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         VelocityFromMesh=True
         UniformMeshScale=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.920000
         FadeInEndTime=0.920000
         MaxParticles=500
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=100.000000,Max=1500.000000))
         MeshScaleRange=(X=(Min=0.100000,Max=15.000000),Y=(Min=0.100000,Max=15.000000),Z=(Min=0.010000,Max=0.010000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=5.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-850.000000)
         ColorScale(0)=(Color=(G=150,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=100,R=150,A=255))
         Opacity=0.500000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.180000
         MaxParticles=125
         StartLocationOffset=(Z=1500.000000)
         StartLocationRange=(X=(Min=-800.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Min=-800.000000,Max=800.000000))
         SphereRadiusRange=(Min=100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.Rev_Particle1'
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=1500.000000,Max=2000.000000))
     End Object
     Emitters(10)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.300000
         FadeOutStartTime=7.350000
         FadeInEndTime=1.950000
         MaxParticles=50
         StartLocationRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000))
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(Z=(Min=150.000000,Max=150.000000))
         VelocityLossRange=(Z=(Min=0.250000,Max=0.250000))
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=1.000000
         MaxParticles=2
         StartLocationOffset=(Z=1500.000000)
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode3'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=0.900000,Max=0.900000)
     End Object
     Emitters(12)=SpriteEmitter'BWBPAirstrikesPro.FAEClusterExplosion.SpriteEmitter6'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     Skins(0)=Texture'EpicParticles.Beams.RadialBands'
     bUnlit=False
}
