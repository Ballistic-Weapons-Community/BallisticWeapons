//-----------------------------------------------------------
//
//-----------------------------------------------------------
class GBU38Explosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         UseCollision=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AlphaTest=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=187.500000)
         ExtentMultiplier=(X=0.400000,Y=0.400000,Z=0.400000)
         ColorScale(0)=(Color=(B=255,G=255,R=225,A=255))
         ColorScale(1)=(RelativeTime=0.032143,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.064286,Color=(B=64,G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=0.121429,Color=(B=128,G=128,R=128,A=255))
         ColorScale(4)=(RelativeTime=1.000000,Color=(B=150,G=128,R=128,A=255))
         Opacity=0.650000
         FadeOutStartTime=6.000000
         FadeInEndTime=2.600000
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=2.000000,Max=5.000000)
         SpinsPerSecondRange=(X=(Max=0.025000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=0.140000,RelativeSize=0.700000)
         SizeScale(3)=(RelativeTime=0.340000,RelativeSize=0.900000)
         SizeScale(4)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=750.000000,Max=1050.000000),Y=(Min=750.000000,Max=1050.000000),Z=(Min=750.000000,Max=1050.000000))
         InitialParticlesPerSecond=25000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(Z=(Min=-750.000000,Max=3000.000000))
         StartVelocityRadialRange=(Min=-600.000000,Max=-300.000000)
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=2.500000,Max=2.500000))
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         ScaleSizeYByVelocity=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=45,G=140,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=160,G=160,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
         Opacity=0.680000
         FadeOutStartTime=0.400000
         MaxParticles=500
         StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         AddLocationFromOtherEmitter=2
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=7.500000,Max=75.000000),Y=(Min=7.500000,Max=75.000000),Z=(Min=7.500000,Max=75.000000))
         ScaleSizeByVelocityMultiplier=(Y=0.003000)
         InitialParticlesPerSecond=250.000000
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.600000,Max=1.600000)
         AddVelocityFromOtherEmitter=2
         AddVelocityMultiplierRange=(X=(Min=0.100000,Max=0.150000),Y=(Min=0.100000,Max=0.150000),Z=(Min=0.100000,Max=0.150000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter21'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'EffectMeshes.Particles.DirtChunk_01aw'
         UseMeshBlendMode=False
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-1000.000000)
         ExtentMultiplier=(X=0.500000,Y=0.500000,Z=0.500000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.740000
         MaxParticles=9
         SpinsPerSecondRange=(X=(Max=2.000000),Y=(Max=2.000000),Z=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         InitialParticlesPerSecond=2500.000000
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=2500.000000
         StartVelocityRange=(X=(Min=-750.000000,Max=1050.000000),Y=(Min=-750.000000,Max=1050.000000),Z=(Min=950.000000,Max=1250.000000))
     End Object
     Emitters(2)=MeshEmitter'BWBPAirstrikesPro.GBU38Explosion.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.010000
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter22'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter24
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
         StartLocationRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Max=375.000000))
         SpinsPerSecondRange=(X=(Min=0.075000,Max=0.150000),Y=(Min=0.075000,Max=0.150000),Z=(Min=0.075000,Max=0.150000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=375.000000,Max=375.000000),Y=(Min=375.000000,Max=375.000000),Z=(Min=375.000000,Max=375.000000))
         InitialParticlesPerSecond=7500.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=1.333333,Max=1.333333)
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=2.500000,Max=2.500000))
         AddVelocityFromOtherEmitter=0
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter24'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter25
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-1425.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=7.500000
         FadeInEndTime=1.600000
         MaxParticles=500
         StartLocationRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=750.000000,Max=750.000000))
         SphereRadiusRange=(Min=1.000000,Max=1.000000)
         StartLocationPolarRange=(X=(Min=-16384.000000,Max=256.000000),Y=(Min=-256.000000,Max=256.000000))
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=7.500000,Max=15.000000),Y=(Min=7.500000,Max=15.000000),Z=(Min=7.500000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=8.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-750.000000,Max=750.000000),Y=(Min=-750.000000,Max=750.000000),Z=(Min=150.000000,Max=2250.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter25'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         Opacity=0.200000
         FadeOutStartTime=4.860000
         FadeInEndTime=0.480000
         MaxParticles=250
         StartLocationRange=(X=(Min=-150.000000,Max=150.000000),Y=(Min=-150.000000,Max=150.000000))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'AW-2004Particles.Energy.CloudLightning'
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-15000.000000,Max=15000.000000),Y=(Min=-15000.000000,Max=15000.000000))
         VelocityLossRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000))
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         StartLocationRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-75.000000,Max=225.000000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=375.000000,Max=375.000000),Y=(Min=375.000000,Max=375.000000),Z=(Min=375.000000,Max=375.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'ExplosionTex.Framed.exp1_frames'
         TextureUSubdivisions=2
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=20
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-75.000000,Max=225.000000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=375.000000,Max=375.000000),Y=(Min=375.000000,Max=375.000000),Z=(Min=375.000000,Max=375.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'ExplosionTex.Framed.we1_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter28'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter29
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=20
         StartLocationRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-75.000000,Max=225.000000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=375.000000,Max=375.000000),Y=(Min=375.000000,Max=375.000000),Z=(Min=375.000000,Max=375.000000))
         InitialParticlesPerSecond=100.000000
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRadialRange=(Min=-40.000000,Max=-50.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter29'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter30
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=3
         DetailMode=DM_High
         StartLocationOffset=(Z=100.000000)
         StartLocationRange=(X=(Min=-75.000000,Max=75.000000))
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=600.000000,Max=600.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=20.000000
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.700000,Max=0.700000)
     End Object
     Emitters(10)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter30'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=20
         StartLocationOffset=(Y=10.000000)
         StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         AddLocationFromOtherEmitter=13
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=225.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'ExplosionTex.Framed.exp1_frames'
         TextureUSubdivisions=2
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(11)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter31'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter32
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         FadeOutStartTime=1.500000
         FadeInEndTime=1.500000
         MaxParticles=50
         StartLocationRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=375.000000,Max=375.000000),Y=(Min=375.000000,Max=375.000000),Z=(Min=375.000000,Max=375.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=5.000000,Max=5.000000)
         InitialDelayRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-75.000000,Max=75.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
     End Object
     Emitters(12)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter32'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-450.000000)
         DampingFactorRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.590000
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=50.000000,Max=50.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaFlare'
         StartVelocityRange=(X=(Min=-375.000000,Max=375.000000),Y=(Min=-375.000000,Max=375.000000),Z=(Min=825.000000,Max=825.000000))
     End Object
     Emitters(13)=SpriteEmitter'BWBPAirstrikesPro.GBU38Explosion.SpriteEmitter33'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
