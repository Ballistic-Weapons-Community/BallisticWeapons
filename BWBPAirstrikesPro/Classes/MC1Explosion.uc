//-----------------------------------------------------------
//
//-----------------------------------------------------------
class MC1Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(X=4.000000,Y=4.000000)
         ColorScale(0)=(Color=(B=150,G=150,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150,A=255))
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.150000,Max=0.150000))
         Opacity=0.500000
         FadeOutStartTime=27.000000
         FadeInEndTime=1.200000
         MaxParticles=250
         StartLocationOffset=(Z=100.000000)
         StartLocationRange=(X=(Min=-1600.000000,Max=1600.000000),Y=(Min=-1600.000000,Max=1600.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=28.000000,Max=30.000000)
         StartVelocityRange=(Z=(Min=4.000000,Max=4.000000))
         MaxAbsVelocity=(X=1.000000,Y=1.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1800.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Z=(Min=0.500000,Max=0.500000))
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=24.000000,Max=24.000000),Y=(Min=24.000000,Max=24.000000),Z=(Min=24.000000,Max=24.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaFlare'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-1400.000000,Max=1400.000000),Y=(Min=-1400.000000,Max=1400.000000),Z=(Min=800.000000,Max=2200.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter19'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(X=4.000000,Y=4.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150,A=255))
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.150000,Max=0.150000))
         Opacity=0.500000
         FadeOutStartTime=27.000000
         FadeInEndTime=1.200000
         MaxParticles=60
         StartLocationOffset=(Z=350.000000)
         StartLocationRange=(X=(Min=-800.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=28.000000,Max=30.000000)
         StartVelocityRange=(Z=(Min=4.000000,Max=4.000000))
         MaxAbsVelocity=(X=1.000000,Y=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
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
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.150000,Max=0.150000))
         FadeOutStartTime=27.600000
         FadeInEndTime=1.200000
         MaxParticles=500
         StartLocationOffset=(Z=100.000000)
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=100.000000,Max=1500.000000))
         MeshScaleRange=(X=(Min=0.100000,Max=14.000000),Y=(Min=0.100000,Max=14.000000),Z=(Min=0.010000,Max=0.010000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=29.000000,Max=30.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter21'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.750000
         FadeOutStartTime=0.005000
         FadeInEndTime=0.005000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=25.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'AW-2004Particles.Energy.AirBlast'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter22'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.150000,Max=0.150000))
         Opacity=0.500000
         FadeOutStartTime=3.000000
         MaxParticles=750
         AddLocationFromOtherEmitter=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=1500.000000
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         LifetimeRange=(Max=5.000000)
         InitialDelayRange=(Min=0.250000,Max=0.250000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter23'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         VelocityFromMesh=True
         UniformMeshScale=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.150000,Max=0.150000))
         Opacity=0.500000
         FadeOutStartTime=2.200000
         FadeInEndTime=0.050000
         MaxParticles=125
         StartLocationOffset=(Z=100.000000)
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=100.000000,Max=1500.000000))
         MeshScaleRange=(X=(Min=0.100000,Max=14.000000),Y=(Min=0.100000,Max=14.000000),Z=(Min=0.010000,Max=0.010000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Max=5.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
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
         ColorMultiplierRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.150000,Max=0.150000))
         FadeOutStartTime=27.600000
         FadeInEndTime=1.200000
         MaxParticles=100
         StartLocationOffset=(Z=100.000000)
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=100.000000,Max=1500.000000))
         MeshScaleRange=(X=(Min=0.100000,Max=14.000000),Y=(Min=0.100000,Max=14.000000),Z=(Min=0.010000,Max=0.010000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=400.000000,Max=400.000000),Y=(Min=400.000000,Max=400.000000),Z=(Min=400.000000,Max=400.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=29.000000,Max=30.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter25'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.150000,Max=0.150000))
         Opacity=0.100000
         MaxParticles=40
         StartSpinRange=(X=(Min=0.250000,Max=0.750000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Dirt.BlastSpray2a'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.500000,RelativeSize=5.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.MC1Explosion.SpriteEmitter27'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
