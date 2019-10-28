//-----------------------------------------------------------
//
//-----------------------------------------------------------
class AIM9MissileTrail extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter15
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(1)=(RelativeTime=0.200000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=255,R=255))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=7
         EffectAxis=PTEA_PositiveZ
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.250000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=30.000000))
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.100000,Max=0.100000)
         StartVelocityRange=(X=(Min=-500.000000,Max=-500.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.AIM9MissileTrail.SpriteEmitter15'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter17
         UseColorScale=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.050000,Color=(B=255,G=255,R=255,A=128))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=128,G=128,R=128,A=128))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128))
         MaxParticles=2500
         StartLocationOffset=(X=-16.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=4.000000)
         UseRotationFrom=PTRS_Actor
         StartSpinRange=(X=(Min=0.550000,Max=0.450000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         ParticlesPerSecond=200.000000
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.MuchSmoke1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=10.000000,Max=10.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.AIM9MissileTrail.SpriteEmitter17'

     AutoDestroy=True
     bNoDelete=False
     bHardAttach=True
}
