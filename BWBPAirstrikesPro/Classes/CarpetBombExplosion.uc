//-----------------------------------------------------------
//
//-----------------------------------------------------------
class CarpetBombExplosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter26
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
         FadeOutStartTime=0.059500
         MaxParticles=5
         StartLocationRange=(Z=(Min=0.498750,Max=0.498750))
         AddLocationFromOtherEmitter=0
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=239.400009,Max=239.400009),Y=(Min=239.400009,Max=239.400009),Z=(Min=239.400009,Max=239.400009))
         InitialParticlesPerSecond=600.000000
         Texture=Texture'ExplosionTex.Framed.we1_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.500000,Max=0.750000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter26'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter27
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
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=18.703125,Max=18.703125),Y=(Min=18.703125,Max=18.703125),Z=(Min=18.703125,Max=18.703125))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter27'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter28
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
         ColorScale(1)=(RelativeTime=0.050000,Color=(B=50,G=150,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.100000,Color=(B=75,G=75,R=75,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=50,G=50,R=50,A=255))
         FadeOutStartTime=7.350000
         FadeInEndTime=1.950000
         StartLocationRange=(X=(Min=-312.500000,Max=312.500000),Y=(Min=-312.500000,Max=312.500000),Z=(Max=375.000000))
         SpinsPerSecondRange=(X=(Max=0.050000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=498.750031,Max=498.750031),Y=(Min=498.750031,Max=498.750031),Z=(Min=498.750031,Max=498.750031))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=10.000000,Max=10.000000)
         StartVelocityRange=(Z=(Min=31.250000,Max=31.250000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter28'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter29
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
         StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=124.687508,Max=124.687508),Y=(Min=124.687508,Max=124.687508),Z=(Min=124.687508,Max=124.687508))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'AW-2004Particles.Fire.GrenadeTest'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter29'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter30
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=100.000000)
         StartSizeRange=(X=(Min=18.703125,Max=18.703125),Y=(Min=18.703125,Max=18.703125),Z=(Min=18.703125,Max=18.703125))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter30'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter31
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
         FadeOutStartTime=0.046666
         FadeInEndTime=0.046666
         MaxParticles=50
         StartLocationRange=(X=(Min=-187.500000,Max=187.500000),Y=(Min=-187.500000,Max=187.500000),Z=(Max=311.718750))
         SpinsPerSecondRange=(X=(Min=0.150000,Max=0.300000),Y=(Min=0.150000,Max=0.300000),Z=(Min=0.150000,Max=0.300000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=311.718750,Max=311.718750),Y=(Min=311.718750,Max=311.718750),Z=(Min=311.718750,Max=311.718750))
         InitialParticlesPerSecond=15000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.166500,Max=1.166500)
         StartVelocityRange=(X=(Min=-625.000000,Max=625.000000),Y=(Min=-625.000000,Max=625.000000),Z=(Min=-2493.750000,Max=1875.000000))
         VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=5.000000,Max=5.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter31'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter32
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
         MaxParticles=2
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.140000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=11.000000)
         SizeScale(2)=(RelativeTime=0.500000,RelativeSize=12.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=13.000000)
         StartSizeRange=(X=(Min=125.000000,Max=125.000000),Y=(Min=125.000000,Max=125.000000),Z=(Min=125.000000,Max=125.000000))
         InitialParticlesPerSecond=10000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode3'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter32'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter71
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.100000
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=3500.000000,Max=3500.000000),Y=(Min=3500.000000,Max=3500.000000),Z=(Min=3500.000000,Max=3500.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.CarpetBombExplosion.SpriteEmitter71'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
