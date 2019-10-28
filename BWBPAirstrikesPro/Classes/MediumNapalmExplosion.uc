//-----------------------------------------------------------
//
//-----------------------------------------------------------
class MediumNapalmExplosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
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
         FadeOutStartTime=3.720000
         FadeInEndTime=0.800000
         StartLocationOffset=(Z=100.000000)
         StartLocationRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000),Z=(Min=7.500000,Max=500.000000))
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.005000,Max=0.005000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=250.000000,Max=750.000000),Y=(Min=250.000000,Max=750.000000),Z=(Min=250.000000,Max=750.000000))
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-187.500000,Max=187.500000),Y=(Min=-187.500000,Max=187.500000),Z=(Min=187.500000,Max=312.500000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter33'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter34
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
         StartLocationOffset=(Z=100.000000)
         StartLocationRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-250.000000,Max=750.000000))
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=450.000000,Max=475.000000),Y=(Min=450.000000,Max=475.000000),Z=(Min=450.000000,Max=475.000000))
         InitialParticlesPerSecond=40.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.200000,Max=3.200000)
         StartVelocityRange=(X=(Min=-375.000000,Max=375.000000),Y=(Min=-375.000000,Max=375.000000),Z=(Min=5.000000,Max=750.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter34'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter35
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
         StartLocationRange=(Z=(Min=1.250000,Max=1.250000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(0)=(RelativeSize=1.010000)
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=3.000000)
         SizeScale(3)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=300.000000,Max=300.000000),Y=(Min=300.000000,Max=300.000000),Z=(Min=300.000000,Max=300.000000))
         InitialParticlesPerSecond=300.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter35'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter36
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
         StartLocationRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-250.000000,Max=750.000000))
         SphereRadiusRange=(Min=180.000000,Max=180.000000)
         SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
         StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
         SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.650000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=450.000000,Max=475.000000),Y=(Min=450.000000,Max=475.000000),Z=(Min=450.000000,Max=475.000000))
         InitialParticlesPerSecond=40.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.200000,Max=3.200000)
         StartVelocityRange=(X=(Min=-375.000000,Max=375.000000),Y=(Min=-375.000000,Max=375.000000),Z=(Min=5.000000,Max=750.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter36'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter37
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-250.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000,Max=0.750000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.930000
         FadeInEndTime=0.090000
         MaxParticles=8
         StartLocationRange=(X=(Min=-375.000000,Max=375.000000),Y=(Min=-375.000000,Max=375.000000),Z=(Min=-375.000000,Max=375.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1000.000000,Max=1000.000000),Y=(Min=1000.000000,Max=1000.000000),Z=(Min=1000.000000,Max=1000.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BenTex01.textures.SnowPuff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.500000)
         StartVelocityRange=(Z=(Min=600.000000,Max=600.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter37'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter38
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
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=15.000000)
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.JumpDuck'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter38'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ExtentMultiplier=(X=0.050000,Y=0.050000,Z=0.010000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=15.200000
         FadeInEndTime=0.800000
         MaxParticles=15
         StartLocationRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'ONSBPTextures.fX.ExploTrans'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=19.000000,Max=20.000000)
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter39'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter41
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=10.560000
         FadeInEndTime=0.360000
         MaxParticles=1
         StartLocationRange=(X=(Min=-375.000000,Max=375.000000),Y=(Min=-375.000000,Max=375.000000),Z=(Min=-375.000000,Max=375.000000))
         StartLocationShape=PTLS_Sphere
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=1300.000000,Max=1300.000000),Y=(Min=1300.000000,Max=1300.000000),Z=(Min=1300.000000,Max=1300.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'EpicParticles.Flares.SoftFlare'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=18.000000,Max=19.000000)
     End Object
     Emitters(7)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter41'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter42
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.500000
         MaxParticles=75
         AddLocationFromOtherEmitter=6
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
         InitialParticlesPerSecond=6.000000
         Texture=Texture'ONSBPTextures.fX.Fire'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(Z=(Min=100.000000,Max=100.000000))
     End Object
     Emitters(8)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter42'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter43
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.500000
         MaxParticles=75
         StartLocationRange=(X=(Min=-500.000000,Max=500.000000),Y=(Min=-500.000000,Max=500.000000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=250.000000,Max=250.000000),Y=(Min=250.000000,Max=250.000000),Z=(Min=250.000000,Max=250.000000))
         InitialParticlesPerSecond=6.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'ExplosionTex.Framed.exp2_frames'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(9)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter43'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
         Acceleration=(X=10.000000,Y=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=1.800000
         FadeInEndTime=1.800000
         MaxParticles=240
         AddLocationFromOtherEmitter=8
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=1.000000,RelativeSize=15.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=24.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=12.000000,Max=13.000000)
         InitialDelayRange=(Min=0.500000,Max=1.000000)
         StartVelocityRange=(Z=(Min=200.000000,Max=200.000000))
     End Object
     Emitters(10)=SpriteEmitter'BWBPAirstrikesPro.MediumNapalmExplosion.SpriteEmitter1'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
