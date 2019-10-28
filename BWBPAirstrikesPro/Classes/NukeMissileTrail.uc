//-----------------------------------------------------------
//
//-----------------------------------------------------------
class NukeMissileTrail extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\EpicParticles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter40
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.480000
         FadeInEndTime=0.480000
         MaxParticles=375
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.310000,RelativeSize=2.500000)
         SizeScale(1)=(RelativeTime=0.620000,RelativeSize=5.000000)
         SizeScale(2)=(RelativeTime=0.810000,RelativeSize=5.500000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=6.000000)
         InitialParticlesPerSecond=25.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Fire.MuchSmoke1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=8.000000,Max=9.000000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.NukeMissileTrail.SpriteEmitter40'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter42
         UseColorScale=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(G=150,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=150,R=255,A=255))
         Opacity=0.300000
         FadeOutStartTime=0.001000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=750.000000,Max=750.000000),Y=(Min=750.000000,Max=750.000000),Z=(Min=750.000000,Max=750.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
         LifetimeRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.NukeMissileTrail.SpriteEmitter42'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter43
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=50
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.NukeMissileTrail.SpriteEmitter43'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter44
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.001000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.NukeMissileTrail.SpriteEmitter44'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_DumbProxy
     bHardAttach=True
}
