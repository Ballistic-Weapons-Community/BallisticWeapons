//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ClusterExplosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter72
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=-200.000000,Max=200.000000)
         StartSpinRange=(X=(Min=1.055000,Max=2.355000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=3.000000)
         InitialParticlesPerSecond=1500.000000
         Texture=Texture'VMParticleTextures.VehicleExplosions.VMExp2_framesANIM'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.ClusterExplosion.SpriteEmitter72'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter75
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.250000
         MaxParticles=5
         StartLocationRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=5.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.ClusterExplosion.SpriteEmitter75'

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
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=100,G=100,R=100,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=100,G=100,R=100,A=255))
         FadeOutStartTime=4.740000
         FadeInEndTime=0.900000
         MaxParticles=8
         StartLocationRange=(X=(Min=-250.000000,Max=250.000000),Y=(Min=-250.000000,Max=250.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=200.000000,Max=200.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=5.000000,Max=7.000000)
         StartVelocityRange=(Z=(Min=20.000000,Max=20.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.ClusterExplosion.SpriteEmitter76'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter77
         FadeOut=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.050000
         MaxParticles=1
         StartSizeRange=(X=(Min=700.000000,Max=700.000000),Y=(Min=700.000000,Max=700.000000),Z=(Min=700.000000,Max=700.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.ClusterExplosion.SpriteEmitter77'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     Skins(0)=Texture'EpicParticles.Beams.RadialBands'
     bUnlit=False
}
