//-----------------------------------------------------------
//
//-----------------------------------------------------------
class GBU43Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter53
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
         StartLocationRange=(X=(Min=-2992.500000,Max=2992.500000),Y=(Min=-2992.500000,Max=2992.500000),Z=(Max=2394.000000))
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.020000,Max=0.020000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=4588.500000,Max=4987.500000),Y=(Min=4588.500000,Max=4987.500000),Z=(Min=4588.500000,Max=4987.500000))
         InitialParticlesPerSecond=80.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Fire.Part_explode3'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000)
         StartVelocityRange=(X=(Min=-2394.000000,Max=2394.000000),Y=(Min=-2394.000000,Max=2394.000000))
         VelocityLossRange=(X=(Min=1.750000,Max=1.750000),Y=(Min=1.750000,Max=1.750000),Z=(Min=1.500000,Max=1.500000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter53'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter54
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.700000
         FadeOutStartTime=0.119000
         MaxParticles=6
         StartLocationRange=(Z=(Min=3.990000,Max=3.990000))
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=1915.200073,Max=1915.200073),Y=(Min=1915.200073,Max=1915.200073),Z=(Min=1915.200073,Max=1915.200073))
         InitialParticlesPerSecond=300.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Fire.Fireballs1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter54'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter55
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
         StartLocationRange=(X=(Min=-4987.500000,Max=4987.500000),Y=(Min=-4987.500000,Max=4987.500000))
         SizeScale(0)=(RelativeSize=5.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=1995.000122,Max=1995.000122),Y=(Min=1995.000122,Max=1995.000122),Z=(Min=1995.000122,Max=1995.000122))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         AddVelocityFromOtherEmitter=2
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter55'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter56
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
         StartSizeRange=(X=(Min=299.250000,Max=299.250000),Y=(Min=299.250000,Max=299.250000),Z=(Min=299.250000,Max=299.250000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter56'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter57
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=150,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=7.350000
         FadeInEndTime=1.950000
         MaxParticles=50
         StartLocationOffset=(Z=1500.000000)
         StartLocationRange=(X=(Min=-3491.250000,Max=3491.250000),Y=(Min=-3491.250000,Max=3491.250000))
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=3990.000244,Max=3990.000244),Y=(Min=3990.000244,Max=3990.000244),Z=(Min=3990.000244,Max=3990.000244))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=20.000000,Max=20.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(Z=(Min=997.500061,Max=997.500061))
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter57'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter58
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
         Opacity=0.500000
         FadeOutStartTime=0.920000
         FadeInEndTime=0.920000
         MaxParticles=500
         MeshSpawningStaticMesh=StaticMesh'ParticleMeshes.Simple.ParticleRing'
         MeshSpawning=PTMS_Random
         VelocityScaleRange=(X=(Min=200.000000,Max=3000.000000))
         MeshScaleRange=(X=(Min=0.400000,Max=60.000000),Y=(Min=0.400000,Max=60.000000),Z=(Min=0.010000,Max=0.010000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1500.000000,Max=1500.000000),Y=(Min=1500.000000,Max=1500.000000),Z=(Min=1500.000000,Max=1500.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=14.000000,Max=15.000000)
         StartVelocityRadialRange=(Min=2500.000000,Max=5000.000000)
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter58'

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
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=150,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.300000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=7.350000
         FadeInEndTime=1.950000
         MaxParticles=50
         StartLocationRange=(X=(Min=-5985.000000,Max=5985.000000),Y=(Min=-5985.000000,Max=5985.000000))
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=3990.000244,Max=3990.000244),Y=(Min=3990.000244,Max=3990.000244),Z=(Min=3990.000244,Max=3990.000244))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=20.000000,Max=20.000000)
         InitialDelayRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(Z=(Min=997.500061,Max=997.500061))
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter59'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter60
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=5
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=997.500061,Max=997.500061),Y=(Min=997.500061,Max=997.500061),Z=(Min=997.500061,Max=997.500061))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Fire.GrenadeTest'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter60'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter61
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-5586.000000)
         ColorScale(0)=(Color=(G=200,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=150,R=200,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=12
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         StartVelocityRange=(X=(Min=-5985.000000,Max=5985.000000),Y=(Min=-5985.000000,Max=5985.000000),Z=(Min=7980.000488,Max=9975.000000))
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter61'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter62
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         MaxParticles=400
         AddLocationFromOtherEmitter=8
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter62'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter63
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
         StartSizeRange=(X=(Min=299.250000,Max=299.250000),Y=(Min=299.250000,Max=299.250000),Z=(Min=299.250000,Max=299.250000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(10)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter63'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter64
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.590000
         FadeOutStartTime=0.093333
         FadeInEndTime=0.093333
         MaxParticles=50
         StartLocationRange=(Z=(Max=2493.750000))
         SpinsPerSecondRange=(X=(Min=0.075000,Max=0.150000),Y=(Min=0.075000,Max=0.150000),Z=(Min=0.075000,Max=0.150000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2493.750000,Max=2493.750000),Y=(Min=2493.750000,Max=2493.750000),Z=(Min=2493.750000,Max=2493.750000))
         InitialParticlesPerSecond=7500.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.333333,Max=1.333333)
         StartVelocityRange=(X=(Min=-9975.000000,Max=9975.000000),Y=(Min=-9975.000000,Max=9975.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=2.500000,Max=2.500000))
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter64'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter65
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=50,G=75,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=50,G=75,R=100,A=255))
         Opacity=0.250000
         FadeOutStartTime=7.200000
         FadeInEndTime=1.200000
         MaxParticles=250
         StartLocationRange=(X=(Min=-897.750000,Max=897.750000),Y=(Min=-897.750000,Max=897.750000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=997.500061,Max=997.500061),Y=(Min=997.500061,Max=997.500061),Z=(Min=997.500061,Max=997.500061))
         InitialParticlesPerSecond=25.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=10.000000,Max=10.000000)
         InitialDelayRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(Z=(Min=997.500061,Max=997.500061))
         StartVelocityRadialRange=(Min=100.000000,Max=100.000000)
     End Object
     Emitters(12)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter65'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter66
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=19.950001)
         ColorScale(0)=(Color=(B=50,G=75,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=50,G=75,R=100,A=255))
         FadeOutStartTime=4.200000
         FadeInEndTime=1.300000
         MaxParticles=250
         StartLocationRange=(X=(Min=-2992.500000,Max=2992.500000),Y=(Min=-2992.500000,Max=2992.500000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=498.750031,Max=498.750031),Y=(Min=498.750031,Max=498.750031),Z=(Min=498.750031,Max=498.750031))
         InitialParticlesPerSecond=25.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Max=0.500000)
         StartVelocityRadialRange=(Min=100.000000,Max=100.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(13)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter66'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter67
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=150,R=250,A=255))
         Opacity=0.500000
         MaxParticles=20
         StartLocationOffset=(Z=2500.000000)
         StartLocationRange=(X=(Min=-2992.500000,Max=2992.500000),Y=(Min=-2992.500000,Max=2992.500000),Z=(Min=-2992.500000,Max=997.500061))
         AddLocationFromOtherEmitter=5
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2660.000000,Max=2660.000000),Y=(Min=2660.000000,Max=2660.000000),Z=(Min=2660.000000,Max=2660.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         LifetimeRange=(Min=7.000000,Max=8.000000)
         InitialDelayRange=(Max=0.500000)
         StartVelocityRange=(Z=(Min=997.500061,Max=997.500061))
     End Object
     Emitters(14)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter67'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter68
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=150,R=250,A=255))
         Opacity=0.500000
         MaxParticles=20
         StartLocationRange=(X=(Min=-4987.500000,Max=4987.500000),Y=(Min=-4987.500000,Max=4987.500000),Z=(Min=-2992.500000,Max=997.500061))
         AddLocationFromOtherEmitter=7
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2660.000000,Max=2660.000000),Y=(Min=2660.000000,Max=2660.000000),Z=(Min=2660.000000,Max=2660.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         LifetimeRange=(Min=7.000000,Max=8.000000)
         InitialDelayRange=(Max=0.500000)
         StartVelocityRange=(Z=(Min=997.500061,Max=997.500061))
     End Object
     Emitters(15)=SpriteEmitter'BWBPAirstrikesPro.GBU43Explosion.SpriteEmitter68'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
