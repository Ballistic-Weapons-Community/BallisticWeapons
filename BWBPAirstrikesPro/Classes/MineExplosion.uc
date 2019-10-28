//-----------------------------------------------------------
//
//-----------------------------------------------------------
class MineExplosion extends Emitter;

#exec OBJ LOAD FILE="..\Textures\AW-2004Explosions.utx"
#exec OBJ LOAD FILE="..\Textures\AW-2004Particles.utx"

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter33
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
         Acceleration=(Z=-1895.250122)
         DampingFactorRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=7.700000
         MaxParticles=250
         SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=9.975000,Max=19.950001),Y=(Min=9.975000,Max=19.950001),Z=(Min=9.975000,Max=19.950001))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=8.000000,Max=10.000000)
         StartVelocityRange=(X=(Min=-498.750000,Max=498.750000),Y=(Min=-498.750000,Max=498.750000),Z=(Min=300.000000,Max=1995.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBPAirstrikesPro.MineExplosion.SpriteEmitter33'

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
         TriggerDisabled=False
         ResetOnTrigger=True
         Acceleration=(Z=-1496.250000)
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
         StartSizeRange=(X=(Min=29.925001,Max=29.925001),Y=(Min=29.925001,Max=29.925001),Z=(Min=29.925001,Max=29.925001))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'EmitterTextures.MultiFrame.smokelight_a'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000)
         StartVelocityRange=(X=(Min=-99.750000,Max=99.750000),Y=(Min=-99.750000,Max=99.750000),Z=(Min=798.000000,Max=1795.500000))
         RelativeWarmupTime=1.000000
     End Object
     Emitters(1)=SpriteEmitter'BWBPAirstrikesPro.MineExplosion.SpriteEmitter34'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter35
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-1895.250122)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.300000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=199.500000,Max=199.500000),Y=(Min=199.500000,Max=199.500000),Z=(Min=199.500000,Max=199.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'VMParticleTextures.TankFiringP.DirtPuffTEX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-99.750000,Max=99.750000),Y=(Min=-99.750000,Max=99.750000),Z=(Min=299.250000,Max=1995.000122))
     End Object
     Emitters(2)=SpriteEmitter'BWBPAirstrikesPro.MineExplosion.SpriteEmitter35'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter36
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-897.750000)
         DampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.300000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=199.500000,Max=199.500000),Y=(Min=199.500000,Max=199.500000),Z=(Min=199.500000,Max=199.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'VMParticleTextures.TankFiringP.DirtPuffTEX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(X=(Min=-598.500000,Max=598.500000),Y=(Min=-598.500000,Max=598.500000),Z=(Min=59.850002,Max=698.250000))
     End Object
     Emitters(3)=SpriteEmitter'BWBPAirstrikesPro.MineExplosion.SpriteEmitter36'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter37
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
         StartLocationRange=(Z=(Max=299.250000))
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         SizeScale(0)=(RelativeTime=0.250000,RelativeSize=10.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=15.000000)
         StartSizeRange=(X=(Min=19.950001,Max=19.950001),Y=(Min=19.950001,Max=19.950001),Z=(Min=19.950001,Max=19.950001))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.350000,Max=0.500000)
         StartVelocityRange=(Z=(Max=199.500000))
     End Object
     Emitters(4)=SpriteEmitter'BWBPAirstrikesPro.MineExplosion.SpriteEmitter37'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter39
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
         StartSizeRange=(X=(Min=59.850002,Max=139.650009),Y=(Min=59.850002,Max=139.650009),Z=(Min=59.850002,Max=139.650009))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Dirt.BlastSpray2a'
         LifetimeRange=(Min=1.000000,Max=1.500000)
     End Object
     Emitters(5)=SpriteEmitter'BWBPAirstrikesPro.MineExplosion.SpriteEmitter39'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Weapons.GrenExpl'
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(6)=SpriteEmitter'BWBPAirstrikesPro.MineExplosion.SpriteEmitter0'

     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     RemoteRole=ROLE_DumbProxy
     bUnlit=False
}
