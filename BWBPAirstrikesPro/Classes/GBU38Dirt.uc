//-----------------------------------------------------------
//
//-----------------------------------------------------------
class GBU38Dirt extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         UseCollision=True
         UseMaxCollisions=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-800.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         MaxCollisions=(Min=6.000000,Max=6.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         MaxParticles=20
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=30.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=6.000000)
         StartVelocityRange=(X=(Min=-1000.000000,Max=1000.000000),Y=(Min=-1000.000000,Max=1000.000000),Z=(Min=200.000000,Max=1800.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter10'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
         StartSizeRange=(X=(Min=4.000000,Max=8.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=3.000000,Max=1.000000)
         InitialDelayRange=(Min=0.250000,Max=0.250000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=0
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter11'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         MaxParticles=75
         DetailMode=DM_High
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=25.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-400.000000,Max=400.000000),Y=(Min=-400.000000,Max=400.000000),Z=(Min=100.000000,Max=1600.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter12'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter13
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
         StartLocationRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000))
         StartLocationShape=PTLS_Polar
         StartLocationPolarRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=50.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=1.500000)
         InitialDelayRange=(Max=0.100000)
         StartVelocityRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Max=50.000000))
         StartVelocityRadialRange=(Min=100.000000,Max=200.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000))
         RotateVelocityLossRange=True
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter13'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter14
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartLocationRange=(Z=(Min=-32.000000,Max=128.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         StartSizeRange=(X=(Min=30.000000,Max=60.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=1.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=100.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=50.000000,Max=1400.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter14'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
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
         MaxParticles=50
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Max=6.000000)
         StartVelocityRange=(X=(Min=-3000.000000,Max=3000.000000),Y=(Min=-3000.000000,Max=3000.000000),Z=(Min=600.000000,Max=5400.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter16
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
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         StartSizeRange=(X=(Min=12.000000,Max=24.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         ScaleSizeByVelocityMultiplier=(X=0.150000,Y=0.150000,Z=0.150000)
         InitialParticlesPerSecond=150.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=3.000000,Max=1.000000)
         VelocityLossRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
         AddVelocityFromOtherEmitter=5
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter16'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-900.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         MaxParticles=75
         DetailMode=DM_High
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Min=-4.000000,Max=4.000000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=3.000000,Max=37.500000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=150.000000,Max=2400.000000))
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter17'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter18
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
         StartLocationRange=(X=(Min=-900.000000,Max=900.000000),Y=(Min=-900.000000,Max=900.000000))
         StartLocationShape=PTLS_Polar
         StartLocationPolarRange=(X=(Min=-128.000000,Max=128.000000),Y=(Min=-128.000000,Max=128.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=2.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=225.000000,Max=450.000000),Y=(Min=450.000000,Max=450.000000),Z=(Min=450.000000,Max=450.000000))
         InitialParticlesPerSecond=1000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=4.500000,Max=4.500000)
         StartVelocityRange=(X=(Min=-2700.000000,Max=2700.000000),Y=(Min=-2700.000000,Max=2700.000000),Z=(Max=225.000000))
         StartVelocityRadialRange=(Min=100.000000,Max=200.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000))
         RotateVelocityLossRange=True
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter18'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter19
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-45.000000)
         ColorScale(0)=(Color=(B=155,G=180,R=205,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=155,G=180,R=205,A=255))
         FadeOutStartTime=1.000000
         FadeInEndTime=0.100000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         StartLocationRange=(Z=(Min=-144.000000,Max=576.000000))
         AlphaRef=4
         SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
         StartSizeRange=(X=(Min=135.000000,Max=270.000000),Y=(Min=450.000000,Max=450.000000),Z=(Min=450.000000,Max=450.000000))
         InitialParticlesPerSecond=500.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTex01.textures.SmokePuff01'
         LifetimeRange=(Min=4.500000,Max=4.500000)
         StartVelocityRange=(X=(Min=-450.000000,Max=450.000000),Y=(Min=-450.000000,Max=450.000000),Z=(Min=225.000000,Max=6300.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
         RotateVelocityLossRange=True
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.GBU38Dirt.SpriteEmitter19'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
