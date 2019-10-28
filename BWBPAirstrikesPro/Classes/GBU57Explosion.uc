//-----------------------------------------------------------
//
//-----------------------------------------------------------
class GBU57Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-2400.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         MaxParticles=60
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=6.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=600.000000,Max=5400.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter25'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter69
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=80
         DetailMode=DM_High
         AddLocationFromOtherEmitter=0
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         StartSizeRange=(X=(Min=12.000000,Max=24.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=3.000000,Max=1.000000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter69'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter70
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-1800.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         MaxParticles=75
         DetailMode=DM_High
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=6.000000,Max=75.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-1200.000000,Max=1200.000000),Y=(Min=-1200.000000,Max=1200.000000),Z=(Min=300.000000,Max=4800.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter70'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter71
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000))
         StartLocationShape=PTLS_Polar
         StartLocationPolarRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=150.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=6.500000,Max=7.000000)
         InitialDelayRange=(Max=0.100000)
         StartVelocityRange=(X=(Min=-1800.000000,Max=1800.000000),Y=(Min=-1800.000000,Max=1800.000000),Z=(Max=150.000000))
         StartVelocityRadialRange=(Min=100.000000,Max=200.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000))
         RotateVelocityLossRange=True
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter71'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter72
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartLocationRange=(Z=(Min=-96.000000,Max=384.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         StartSizeRange=(X=(Min=90.000000,Max=180.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=6.500000,Max=7.000000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=150.000000,Max=4200.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter72'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter73
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-7200.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         MaxParticles=50
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=90.000000,Max=90.000000),Y=(Min=90.000000,Max=90.000000),Z=(Min=90.000000,Max=90.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=6.000000)
         StartVelocityRange=(X=(Min=-9000.000000,Max=9000.000000),Y=(Min=-9000.000000,Max=9000.000000),Z=(Min=1800.000000,Max=16200.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter73'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter74
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         FadeInEndTime=0.100000
         MaxParticles=80
         DetailMode=DM_High
         AddLocationFromOtherEmitter=5
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
         StartSizeRange=(X=(Min=36.000000,Max=72.000000),Y=(Min=900.000000,Max=900.000000),Z=(Min=900.000000,Max=900.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=3.000000,Max=1.000000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=5
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter74'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter75
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-2700.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         MaxParticles=150
         DetailMode=DM_High
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=20.500000,Max=50.500000),Y=(Min=20.500000,Max=50.500000),Z=(Min=20.500000,Max=50.500000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-1800.000000,Max=1800.000000),Y=(Min=-1800.000000,Max=1800.000000),Z=(Min=450.000000,Max=7200.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter75'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter76
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationRange=(X=(Min=-2700.000000,Max=2700.000000),Y=(Min=-2700.000000,Max=2700.000000))
         StartLocationShape=PTLS_Polar
         StartLocationPolarRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=675.000000,Max=1350.000000),Y=(Min=1350.000000,Max=1350.000000),Z=(Min=1350.000000,Max=1350.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=6.500000,Max=7.500000)
         StartVelocityRange=(X=(Min=-8100.000000,Max=8100.000000),Y=(Min=-8100.000000,Max=8100.000000),Z=(Max=675.000000))
         StartVelocityRadialRange=(Min=100.000000,Max=200.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000))
         RotateVelocityLossRange=True
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter76'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter77
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-135.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartLocationRange=(Z=(Min=-432.000000,Max=1728.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         StartSizeRange=(X=(Min=405.000000,Max=810.000000),Y=(Min=1350.000000,Max=1350.000000),Z=(Min=1350.000000,Max=1350.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=6.500000,Max=7.500000)
         StartVelocityRange=(X=(Min=-1350.000000,Max=1350.000000),Y=(Min=-1350.000000,Max=1350.000000),Z=(Min=675.000000,Max=18900.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter77'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter85
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         ResetOnTrigger=True
         Acceleration=(Z=-17057.251953)
         DampingFactorRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=7.700000
         MaxParticles=500
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=25.549999,Max=50.549999),Y=(Min=25.549999,Max=50.549999),Z=(Min=25.549999,Max=50.549999))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=8.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-4488.750000,Max=4488.750000),Y=(Min=-4488.750000,Max=4488.750000),Z=(Min=2700.000000,Max=17955.000000))
     End Object
     Emitters(10)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter85'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter86
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         TriggerDisabled=False
         ResetOnTrigger=True
         Acceleration=(Z=-7500.250000)
         ColorScale(0)=(Color=(B=34,G=141,R=238))
         ColorScale(1)=(RelativeTime=0.250000,Color=(B=43,G=68,R=77))
         ColorScale(2)=(RelativeTime=0.896429,Color=(B=51,G=51,R=51))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.750000,Max=0.750000))
         FadeOutFactor=(W=0.250000,X=0.100000,Y=0.100000,Z=0.100000)
         FadeOutStartTime=0.750000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         SizeScale(0)=(RelativeTime=0.500000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=269.325012,Max=269.325012),Y=(Min=269.325012,Max=269.325012),Z=(Min=269.325012,Max=269.325012))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EmitterTextures.MultiFrame.smokelight_a'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000)
         StartVelocityRange=(X=(Min=-897.750000,Max=897.750000),Y=(Min=-897.750000,Max=897.750000),Z=(Min=7182.000000,Max=16159.500000))
         RelativeWarmupTime=1.000000
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter86'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter87
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-12000.251953)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.300000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1795.500000,Max=1795.500000),Y=(Min=1795.500000,Max=1795.500000),Z=(Min=1795.500000,Max=1795.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'VMParticleTextures.TankFiringP.DirtPuffTEX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-897.750000,Max=897.750000),Y=(Min=-897.750000,Max=897.750000),Z=(Min=2693.250000,Max=17955.001953))
     End Object
     Emitters(12)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter87'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter88
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-5000.750000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.300000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1795.500000,Max=1795.500000),Y=(Min=1795.500000,Max=1795.500000),Z=(Min=1795.500000,Max=1795.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'VMParticleTextures.TankFiringP.DirtPuffTEX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-3386.500000,Max=3386.500000),Y=(Min=-3386.500000,Max=3386.500000),Z=(Min=538.650024,Max=6284.250000))
     End Object
     Emitters(13)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter88'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter89
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
         FadeOutStartTime=0.500000
         FadeInEndTime=0.500000
         StartLocationRange=(Z=(Max=2693.250000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.250000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=15.000000)
         StartSizeRange=(X=(Min=179.550003,Max=179.550003),Y=(Min=179.550003,Max=179.550003),Z=(Min=179.550003,Max=179.550003))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.350000,Max=0.500000)
         StartVelocityRange=(Z=(Max=1795.500000))
     End Object
     Emitters(14)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter89'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter90
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=75,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=50,R=100,A=255))
         Opacity=0.500000
         MaxParticles=25
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.310000,RelativeSize=5.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=538.650024,Max=1256.850098),Y=(Min=538.650024,Max=1256.850098),Z=(Min=538.650024,Max=1256.850098))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Dirt.BlastSpray2a'
         LifetimeRange=(Min=1.000000,Max=1.500000)
     End Object
     Emitters(15)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter90'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter91
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.150000
         MaxParticles=2
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=90.000000,Max=90.000000),Y=(Min=90.000000,Max=90.000000),Z=(Min=90.000000,Max=90.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.GrenExpl'
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(16)=SpriteEmitter'BWBPAirstrikesPro.GBU57Explosion.SpriteEmitter91'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     Skins(0)=Texture'EpicParticles.Beams.RadialBands'
     bUnlit=False
}
