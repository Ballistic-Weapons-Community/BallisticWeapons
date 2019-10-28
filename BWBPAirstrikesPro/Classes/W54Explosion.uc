//-----------------------------------------------------------
//
//-----------------------------------------------------------
class W54Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter46
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=100,G=100,R=100,A=255))
         ColorScale(2)=(RelativeTime=0.346429,Color=(B=75,G=75,R=75,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=50,G=50,R=50,A=255))
         FadeOutStartTime=27.600000
         FadeInEndTime=1.200000
         MaxParticles=50
         StartLocationRange=(X=(Min=-5625.000000,Max=5625.000000),Y=(Min=-5625.000000,Max=5625.000000),Z=(Min=-1125.000000,Max=1125.000000))
         StartLocationPolarRange=(X=(Min=16.000000,Max=16.000000),Y=(Min=32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=5625.000000,Max=5625.000000),Y=(Min=5625.000000,Max=5625.000000),Z=(Min=5625.000000,Max=5625.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=30.000000,Max=30.000000)
         StartVelocityRange=(Z=(Min=1687.500000,Max=1687.500000))
         VelocityLossRange=(Z=(Min=0.050000,Max=0.050000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter46'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter47
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.300000,Color=(B=100,G=100,R=100,A=255))
         ColorScale(2)=(RelativeTime=0.346429,Color=(B=75,G=75,R=75,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=50,G=50,R=50,A=255))
         FadeOutStartTime=27.600000
         FadeInEndTime=1.200000
         MaxParticles=50
         StartLocationOffset=(Z=3750.000000)
         StartLocationRange=(X=(Min=-3375.000000,Max=3375.000000),Y=(Min=-3375.000000,Max=3375.000000),Z=(Min=-1125.000000,Max=1125.000000))
         StartLocationPolarRange=(X=(Min=16.000000,Max=16.000000),Y=(Min=32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=5625.000000,Max=5625.000000),Y=(Min=5625.000000,Max=5625.000000),Z=(Min=5625.000000,Max=5625.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=30.000000,Max=30.000000)
         StartVelocityRange=(Z=(Min=1687.500000,Max=1687.500000))
         VelocityLossRange=(Z=(Min=0.050000,Max=0.050000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter47'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter48
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=150,G=150,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         FadeOutStartTime=4.200000
         FadeInEndTime=1.300000
         MaxParticles=125
         StartLocationRange=(X=(Min=-15000.000000,Max=15000.000000),Y=(Min=-15000.000000,Max=15000.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1875.000000,Max=1875.000000),Y=(Min=1875.000000,Max=1875.000000),Z=(Min=1875.000000,Max=1875.000000))
         InitialParticlesPerSecond=12.500000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Max=0.500000)
         StartVelocityRadialRange=(Min=500.000000,Max=500.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter48'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter49
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=150,G=150,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         FadeOutStartTime=7.200000
         FadeInEndTime=1.200000
         MaxParticles=500
         StartLocationRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1406.250000,Max=1406.250000),Y=(Min=1406.250000,Max=1406.250000),Z=(Min=1406.250000,Max=1406.250000))
         InitialParticlesPerSecond=25.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=15.500000,Max=15.500000)
         StartVelocityRange=(Z=(Min=1687.500000,Max=1687.500000))
         StartVelocityRadialRange=(Min=100.000000,Max=100.000000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter49'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter50
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=175,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=175,R=255,A=255))
         Opacity=0.500000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationNormal=(Z=1.000000)
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=5625.000000,Max=5625.000000),Y=(Min=5625.000000,Max=5625.000000),Z=(Min=5625.000000,Max=5625.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter50'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter51
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.250000,Color=(G=200,R=200,A=255))
         ColorScale(2)=(RelativeTime=0.500000,Color=(B=50,G=125,R=150,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=50,G=100,R=150,A=255))
         MaxParticles=5
         StartLocationOffset=(Z=500.000000)
         SpinsPerSecondRange=(X=(Min=0.020000,Max=0.020000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.250000,RelativeSize=0.750000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.750000)
         StartSizeRange=(X=(Min=35000.000000,Max=35000.000000),Y=(Min=35000.000000,Max=35000.000000),Z=(Min=35000.000000,Max=35000.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Fire.SmallBang'
         LifetimeRange=(Min=13.000000,Max=13.000000)
         AddVelocityFromOtherEmitter=1
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter51'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter52
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.500000
         FadeInEndTime=2.500000
         MaxParticles=100
         AddLocationFromOtherEmitter=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=3000.000000,Max=3000.000000),Y=(Min=3000.000000,Max=3000.000000),Z=(Min=3000.000000,Max=3000.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=8.000000,Max=10.000000)
         InitialDelayRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
         VelocityLossRange=(Z=(Min=0.050000,Max=0.050000))
         AddVelocityFromOtherEmitter=1
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter52'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter53
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.500000
         FadeInEndTime=2.500000
         MaxParticles=100
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=3000.000000,Max=3000.000000),Y=(Min=3000.000000,Max=3000.000000),Z=(Min=3000.000000,Max=3000.000000))
         InitialParticlesPerSecond=30.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=8.000000,Max=10.000000)
         InitialDelayRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
         VelocityLossRange=(Z=(Min=0.050000,Max=0.050000))
         AddVelocityFromOtherEmitter=1
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter53'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter54
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         VelocityFromMesh=True
         UniformMeshScale=False
         UniformVelocityScale=False
         SpawnOnlyInDirectionOfNormal=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=200,G=200,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=200,G=200,R=200,A=255))
         Opacity=0.250000
         FadeOutStartTime=3.200000
         FadeInEndTime=3.200000
         MaxParticles=250
         StartLocationOffset=(Z=11250.000000)
         StartLocationShape=PTLS_Polar
         StartLocationPolarRange=(X=(Min=16384.000000,Max=16384.000000),Y=(Min=8192.000000,Max=8192.000000),Z=(Min=1000.000000,Max=1000.000000))
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=5000.000000,Max=5000.000000),Y=(Min=5000.000000,Max=5000.000000),Z=(Min=0.000000,Max=0.000000))
         MeshScaleRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=0.010000,Max=0.010000))
         MeshNormal=(X=16384.000000,Y=16384.000000,Z=0.000000)
         MeshNormalThresholdRange=(Min=16384.000000,Max=16384.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1500.000000,Max=1500.000000),Y=(Min=1500.000000,Max=1500.000000),Z=(Min=1500.000000,Max=1500.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=5.000000)
         StartVelocityRadialRange=(Min=-1000.000000,Max=1000.000000)
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter54'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter55
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         VelocityFromMesh=True
         UniformMeshScale=False
         UniformVelocityScale=False
         SpawnOnlyInDirectionOfNormal=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=200,G=200,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=200,G=200,R=200,A=255))
         Opacity=0.250000
         FadeOutStartTime=3.200000
         FadeInEndTime=3.200000
         MaxParticles=250
         StartLocationOffset=(Z=15000.000000)
         StartLocationShape=PTLS_Polar
         StartLocationPolarRange=(X=(Min=16384.000000,Max=16384.000000),Y=(Min=8192.000000,Max=8192.000000),Z=(Min=1000.000000,Max=1000.000000))
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=3000.000000,Max=3000.000000),Y=(Min=3000.000000,Max=3000.000000),Z=(Min=0.000000,Max=0.000000))
         MeshScaleRange=(Z=(Min=0.010000,Max=0.010000))
         MeshNormal=(X=16384.000000,Y=16384.000000,Z=0.000000)
         MeshNormalThresholdRange=(Min=16384.000000,Max=16384.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1500.000000,Max=1500.000000),Y=(Min=1500.000000,Max=1500.000000),Z=(Min=1500.000000,Max=1500.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=5.000000)
         StartVelocityRadialRange=(Min=-1000.000000,Max=1000.000000)
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter55'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'VMmeshEmitted.EJECTA.Sphere'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.250000
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=1
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(10)=MeshEmitter'BWBPAirstrikesPro.W54Explosion.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter56
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=150,G=150,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=150,G=150,R=150,A=255))
         FadeOutStartTime=11.850000
         FadeInEndTime=1.200000
         MaxParticles=150
         StartLocationRange=(X=(Min=-20000.000000,Max=20000.000000),Y=(Min=-20000.000000,Max=20000.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2000.000000,Max=2000.000000),Y=(Min=2000.000000,Max=2000.000000),Z=(Min=2000.000000,Max=2000.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=30.000000,Max=30.000000)
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter56'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter57
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         VelocityFromMesh=True
         UniformMeshScale=False
         UniformVelocityScale=False
         SpawnOnlyInDirectionOfNormal=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=150,G=150,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         Opacity=0.750000
         FadeOutStartTime=25.500000
         FadeInEndTime=3.600000
         MaxParticles=250
         StartLocationShape=PTLS_Polar
         StartLocationPolarRange=(X=(Min=16384.000000,Max=16384.000000),Y=(Min=8192.000000,Max=8192.000000),Z=(Min=1000.000000,Max=1000.000000))
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         MeshScaleRange=(X=(Min=100.000000,Max=500.000000),Y=(Min=100.000000,Max=500.000000),Z=(Min=0.010000,Max=0.010000))
         MeshNormal=(X=16384.000000,Y=16384.000000,Z=0.000000)
         MeshNormalThresholdRange=(Min=16384.000000,Max=16384.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2000.000000,Max=2000.000000),Y=(Min=2000.000000,Max=2000.000000),Z=(Min=2000.000000,Max=2000.000000))
         InitialParticlesPerSecond=500000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=29.000000,Max=30.000000)
         StartVelocityRadialRange=(Min=-1000.000000,Max=1000.000000)
     End Object
     Emitters(12)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter57'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter58
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=175,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=175,R=255,A=255))
         Opacity=0.500000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationNormal=(Z=1.000000)
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=5625.000000,Max=5625.000000),Y=(Min=5625.000000,Max=5625.000000),Z=(Min=5625.000000,Max=5625.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(13)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter58'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter59
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=150,G=150,R=150,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         FadeOutStartTime=4.200000
         FadeInEndTime=1.300000
         MaxParticles=250
         StartLocationRange=(X=(Min=-7500.000000,Max=7500.000000),Y=(Min=-7500.000000,Max=7500.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1875.000000,Max=1875.000000),Y=(Min=1875.000000,Max=1875.000000),Z=(Min=1875.000000,Max=1875.000000))
         InitialParticlesPerSecond=25.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Max=0.500000)
         StartVelocityRadialRange=(Min=500.000000,Max=500.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(14)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter59'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter60
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
         MaxParticles=5
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=2500.000000,Max=2500.000000),Y=(Min=2500.000000,Max=2500.000000),Z=(Min=2500.000000,Max=2500.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(15)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter60'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter61
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.640000
         FadeInEndTime=0.640000
         StartLocationRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=25000.000000,Max=25000.000000),Y=(Min=25000.000000,Max=25000.000000),Z=(Min=25000.000000,Max=25000.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EmitterTextures.Flares.EFlareOY'
         LifetimeRange=(Min=5.000000,Max=6.000000)
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(16)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter61'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter62
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=50,G=75,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=50,G=75,R=100,A=255))
         FadeOutStartTime=2.900000
         FadeInEndTime=1.200000
         MaxParticles=300
         StartLocationRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000))
         AddLocationFromOtherEmitter=3
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=5.000000,Max=6.000000)
         InitialDelayRange=(Min=3.000000,Max=4.000000)
         StartVelocityRange=(Z=(Min=1687.500000,Max=1687.500000))
         StartVelocityRadialRange=(Min=100.000000,Max=100.000000)
     End Object
     Emitters(17)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter62'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter63
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=175,R=255,A=255))
         FadeOutStartTime=5.000000
         MaxParticles=2
         StartLocationOffset=(Z=1500.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=25.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=27.000000)
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=15.000000,Max=15.000000)
         VelocityLossRange=(Z=(Min=0.025000,Max=0.025000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(18)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter63'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter64
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=175,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=7.400000
         MaxParticles=1
         StartLocationOffset=(Z=1500.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=25.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=27.000000)
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=10.000000,Max=10.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         VelocityLossRange=(Z=(Min=0.025000,Max=0.025000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(19)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter64'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter65
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.500000
         FadeInEndTime=2.500000
         MaxParticles=100
         AddLocationFromOtherEmitter=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2250.000000,Max=2250.000000),Y=(Min=2250.000000,Max=2250.000000),Z=(Min=2250.000000,Max=2250.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=8.000000,Max=10.000000)
         InitialDelayRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
         AddVelocityFromOtherEmitter=1
     End Object
     Emitters(20)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter65'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter66
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.500000
         FadeInEndTime=2.500000
         MaxParticles=100
         AddLocationFromOtherEmitter=0
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2250.000000,Max=2250.000000),Y=(Min=2250.000000,Max=2250.000000),Z=(Min=2250.000000,Max=2250.000000))
         InitialParticlesPerSecond=30.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=8.000000,Max=10.000000)
         InitialDelayRange=(Min=1.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
         AddVelocityFromOtherEmitter=1
     End Object
     Emitters(21)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter66'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter67
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=175,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=175,R=255,A=255))
         Opacity=0.010000
         MaxParticles=120
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationNormal=(Z=1.000000)
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=1000.000000,Max=4000.000000),Y=(Min=1000.000000,Max=4000.000000),Z=(Min=1000.000000,Max=4000.000000))
         InitialParticlesPerSecond=180.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaRing'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(22)=SpriteEmitter'BWBPAirstrikesPro.W54Explosion.SpriteEmitter67'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     Skins(0)=Texture'EpicParticles.Beams.RadialBands'
     bUnlit=False
}
