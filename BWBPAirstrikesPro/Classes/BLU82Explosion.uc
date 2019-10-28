//-----------------------------------------------------------
//
//-----------------------------------------------------------
class BLU82Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
         StartLocationRange=(X=(Min=-480.000000,Max=480.000000),Y=(Min=-480.000000,Max=480.000000),Z=(Min=-600.000000,Max=1800.000000))
         AddLocationFromOtherEmitter=4
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=2700.000000,Max=3000.000000),Y=(Min=2700.000000,Max=3000.000000),Z=(Min=2700.000000,Max=3000.000000))
         InitialParticlesPerSecond=80.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Fire.Part_explode3'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000)
         StartVelocityRange=(X=(Min=-1800.000000,Max=1800.000000),Y=(Min=-1800.000000,Max=1800.000000))
         VelocityLossRange=(X=(Min=1.750000,Max=1.750000),Y=(Min=1.750000,Max=1.750000),Z=(Min=1.500000,Max=1.500000))
         AddVelocityFromOtherEmitter=10
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         StartLocationRange=(Z=(Min=3.000000,Max=3.000000))
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=1440.000000,Max=1440.000000),Y=(Min=1440.000000,Max=1440.000000),Z=(Min=1440.000000,Max=1440.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
         StartLocationRange=(X=(Min=-480.000000,Max=480.000000),Y=(Min=-480.000000,Max=480.000000),Z=(Min=-600.000000,Max=1800.000000))
         AddLocationFromOtherEmitter=4
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=2700.000000,Max=3000.000000),Y=(Min=2700.000000,Max=3000.000000),Z=(Min=2700.000000,Max=3000.000000))
         InitialParticlesPerSecond=80.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000)
         StartVelocityRange=(X=(Min=-1800.000000,Max=1800.000000),Y=(Min=-1800.000000,Max=1800.000000),Z=(Min=24.000000,Max=600.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
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
         StartSizeRange=(X=(Min=1500.000000,Max=1500.000000),Y=(Min=1500.000000,Max=1500.000000),Z=(Min=1500.000000,Max=1500.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityFromOtherEmitter=2
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
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
         Opacity=0.500000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=225.000000,Max=225.000000),Y=(Min=225.000000,Max=225.000000),Z=(Min=225.000000,Max=225.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter4'

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
         StartLocationOffset=(Z=500.000000)
         StartLocationRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000))
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=3000.000000,Max=3000.000000),Y=(Min=3000.000000,Max=3000.000000),Z=(Min=3000.000000,Max=3000.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Min=2.500000,Max=2.500000)
         StartVelocityRange=(Z=(Min=450.000000,Max=450.000000))
         VelocityLossRange=(Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
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
         MeshScaleRange=(X=(Min=0.200000,Max=30.000000),Y=(Min=0.200000,Max=30.000000),Z=(Min=0.010000,Max=0.010000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1500.000000,Max=1500.000000),Y=(Min=1500.000000,Max=1500.000000),Z=(Min=1500.000000,Max=1500.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=10.000000,Max=11.000000)
         StartVelocityRadialRange=(Min=2500.000000,Max=5000.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-2550.000000)
         ColorScale(0)=(Color=(G=150,R=200,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=100,R=150,A=255))
         Opacity=0.500000
         FadeOutStartTime=0.180000
         FadeInEndTime=0.180000
         MaxParticles=125
         StartLocationRange=(X=(Min=-2400.000000,Max=2400.000000),Y=(Min=-2400.000000,Max=2400.000000),Z=(Min=-2400.000000,Max=2400.000000))
         StartLocationShape=PTLS_Polar
         SphereRadiusRange=(Min=100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.Rev_Particle1'
         LifetimeRange=(Min=5.000000,Max=5.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=2500.000000,Max=6000.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
         StartLocationRange=(X=(Min=-4500.000000,Max=4500.000000),Y=(Min=-4500.000000,Max=4500.000000))
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=3000.000000,Max=3000.000000),Y=(Min=3000.000000,Max=3000.000000),Z=(Min=3000.000000,Max=3000.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(Z=(Min=450.000000,Max=450.000000))
         VelocityLossRange=(Z=(Min=0.250000,Max=0.250000))
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
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
         StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-4200.000000)
         ColorScale(0)=(Color=(G=200,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=150,R=200,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         StartVelocityRange=(X=(Min=-4500.000000,Max=4500.000000),Y=(Min=-4500.000000,Max=4500.000000),Z=(Min=6000.000000,Max=7500.000000))
     End Object
     Emitters(10)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
         MaxParticles=400
         AddLocationFromOtherEmitter=10
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
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
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=225.000000,Max=225.000000),Y=(Min=225.000000,Max=225.000000),Z=(Min=225.000000,Max=225.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(12)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
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
         Opacity=0.590000
         FadeOutStartTime=0.093333
         FadeInEndTime=0.093333
         MaxParticles=50
         StartLocationRange=(X=(Min=-3750.000000,Max=3750.000000),Y=(Min=-3750.000000,Max=3750.000000),Z=(Max=1875.000000))
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.075000,Max=0.150000),Y=(Min=0.075000,Max=0.150000),Z=(Min=0.075000,Max=0.150000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1875.000000,Max=1875.000000),Y=(Min=1875.000000,Max=1875.000000),Z=(Min=1875.000000,Max=1875.000000))
         InitialParticlesPerSecond=7500.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.333000,Max=2.333000)
         StartVelocityRange=(X=(Min=-5500.000000,Max=5500.000000),Y=(Min=-5500.000000,Max=5500.000000))
         VelocityLossRange=(X=(Min=0.850000,Max=0.850000),Y=(Min=0.850000,Max=0.850000))
     End Object
     Emitters(13)=SpriteEmitter'BWBPAirstrikesPro.BLU82Explosion.SpriteEmitter13'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
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
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(14)=MeshEmitter'BWBPAirstrikesPro.BLU82Explosion.MeshEmitter0'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     Skins(0)=Texture'EpicParticles.Beams.RadialBands'
     bUnlit=False
}
