//-----------------------------------------------------------
//
//-----------------------------------------------------------
class MK77Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter85
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(1)=(RelativeTime=0.171429,Color=(B=56,G=56,R=56,A=255))
         ColorScale(2)=(RelativeTime=0.639286,Color=(B=77,G=77,R=77,A=255))
         ColorScale(3)=(RelativeTime=0.875000,Color=(B=53,G=53,R=53,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(A=255))
         ColorScale(5)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(6)=(RelativeTime=1.000000)
         FadeOutStartTime=1.860000
         FadeInEndTime=0.400000
         MaxParticles=25
         DetailMode=DM_High
         StartLocationOffset=(Z=200.000000)
         StartLocationRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=15.000000,Max=1000.000000))
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=0.010000,Max=0.025000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=500.000000,Max=1500.000000),Y=(Min=500.000000,Max=1500.000000),Z=(Min=500.000000,Max=1500.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=15.000000,Max=15.000000)
         InitialDelayRange=(Max=0.006400)
         StartVelocityRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=750.000000,Max=1250.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter85'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter86
         UseDirectionAs=PTDU_Normal
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
         Opacity=0.480000
         FadeOutStartTime=3.027200
         MaxParticles=4
         StartLocationRange=(Z=(Min=2.500000,Max=2.500000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter86'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter87
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
         FadeOutStartTime=1.372380
         DetailMode=DM_High
         StartLocationOffset=(Z=200.000000)
         StartLocationRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Max=1500.000000))
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=900.000000,Max=950.000000),Y=(Min=900.000000,Max=950.000000),Z=(Min=900.000000,Max=950.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000)
         StartVelocityRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=10.000000,Max=1500.000000))
         VelocityLossRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter87'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter88
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
         FadeOutStartTime=0.238000
         MaxParticles=3
         StartLocationRange=(Z=(Min=2.500000,Max=2.500000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter88'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter89
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
         FadeOutStartTime=1.372380
         DetailMode=DM_High
         StartLocationOffset=(Z=200.000000)
         StartLocationRange=(X=(Min=-875.000000,Max=875.000000),Y=(Min=-875.000000,Max=875.000000),Z=(Max=250.000000))
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=900.000000,Max=950.000000),Y=(Min=900.000000,Max=950.000000),Z=(Min=900.000000,Max=950.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=3.000000)
         StartVelocityRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=10.000000,Max=1500.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter89'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter90
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=175,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=175,R=255,A=255))
         Opacity=0.670000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationNormal=(Z=1.000000)
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter90'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter91
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=250
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         LifetimeRange=(Min=5.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=1000.000000,Max=1500.000000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter91'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter92
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.000000))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=50
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.HardSpot'
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1500.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter92'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter93
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=0.480000
         FadeInEndTime=0.480000
         MaxParticles=4000
         AddLocationFromOtherEmitter=7
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter93'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter94
         UseDirectionAs=PTDU_Normal
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         Acceleration=(Z=-950.000000)
         ExtentMultiplier=(Z=0.050000)
         DampingFactorRange=(X=(Min=0.010000,Max=0.010000),Y=(Min=0.010000,Max=0.010000),Z=(Min=0.010000,Max=0.010000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.750000
         FadeOutStartTime=7.500000
         FadeInEndTime=7.500000
         MaxParticles=120
         StartLocationOffset=(Z=500.000000)
         StartLocationRange=(X=(Min=-2000.000000,Max=2000.000000),Y=(Min=-2000.000000,Max=2000.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.500000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
         InitialParticlesPerSecond=60.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=25.000000,Max=25.000000)
         InitialDelayRange=(Min=1.000000,Max=2.000000)
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter94'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter95
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
         Opacity=0.500000
         FadeOutStartTime=3.750000
         FadeInEndTime=3.750000
         MaxParticles=120
         AddLocationFromOtherEmitter=9
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.500000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=15.000000)
         InitialParticlesPerSecond=8.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         LifetimeRange=(Min=20.000000,Max=20.000000)
         StartVelocityRange=(Z=(Min=300.000000,Max=300.000000))
     End Object
     Emitters(10)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter95'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter96
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=0.240000
         FadeInEndTime=0.240000
         MaxParticles=1500
         StartLocationRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000))
         AddLocationFromOtherEmitter=9
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'ONSBPTextures.fX.Fire'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=3.500000,Max=4.500000)
         StartVelocityRange=(Z=(Min=150.000000,Max=150.000000))
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter96'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter97
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=175,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=175,R=255,A=255))
         Opacity=0.670000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         RotationNormal=(Z=1.000000)
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=10.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(12)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter97'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter98
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-500.000000)
         DampingFactorRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         ColorScale(0)=(Color=(G=150,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=150,R=255,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=50
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=1000.000000,Max=1500.000000))
     End Object
     Emitters(13)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter98'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter99
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         ColorScale(0)=(Color=(G=150,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=2.000000
         FadeInEndTime=2.000000
         MaxParticles=25
         StartLocationRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Max=500.000000))
         AddLocationFromOtherEmitter=2
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=10.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         InitialDelayRange=(Min=0.500000,Max=1.000000)
     End Object
     Emitters(14)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter99'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter100
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=2.000000
         MaxParticles=1500
         AddLocationFromOtherEmitter=9
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         InitialDelayRange=(Min=3.000000,Max=4.000000)
     End Object
     Emitters(15)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter100'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter101
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.250000,Max=0.250000))
         Opacity=0.150000
         FadeOutStartTime=12.450000
         FadeInEndTime=0.750000
         MaxParticles=25
         StartLocationRange=(X=(Min=-1500.000000,Max=1500.000000),Y=(Min=-1500.000000,Max=1500.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2500.000000,Max=2500.000000),Y=(Min=2500.000000,Max=2500.000000),Z=(Min=2500.000000,Max=2500.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=24.000000,Max=25.000000)
     End Object
     Emitters(16)=SpriteEmitter'BWBPAirstrikesPro.MK77Explosion.SpriteEmitter101'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     Skins(0)=Texture'EpicParticles.Beams.RadialBands'
     bUnlit=False
}
