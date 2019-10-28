//-----------------------------------------------------------
//
//-----------------------------------------------------------
class JSOWShellSplit extends Emitter;

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'AW-2004Particles.Debris.Veh_Debris2'
         UseMeshBlendMode=False
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-800.000000)
         ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.850000,Color=(B=128,G=128,R=128,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         MaxParticles=6
         DetailMode=DM_High
         StartLocationOffset=(Z=50.000000)
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=12.000000,Max=30.000000)
         UseRotationFrom=PTRS_Actor
         SpinsPerSecondRange=(X=(Max=0.500000),Y=(Max=0.500000),Z=(Max=2.000000))
         StartSizeRange=(X=(Min=0.500000))
         InitialParticlesPerSecond=5000.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=1.000000,Max=1.000000)
         InitialDelayRange=(Min=0.200000,Max=0.200000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000))
         StartVelocityRadialRange=(Min=-300.000000,Max=-800.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=MeshEmitter'OnslaughtBP.ONSDualACDeathExp.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter2
         StaticMesh=StaticMesh'AW-2k4XP.Weapons.ShockShield'
         UseParticleColor=True
         UseColorScale=True
         RespawnDeadParticles=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=70,G=70,R=255))
         ColorScale(1)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=5000.000000
         LifetimeRange=(Min=0.200000,Max=0.200000)
     End Object
     Emitters(1)=MeshEmitter'OnslaughtBP.ONSShockTankShieldHitEffectRed.MeshEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(1)=(RelativeTime=0.100000,Color=(B=255,G=74,R=124))
         ColorScale(2)=(RelativeTime=0.800000,Color=(B=255,G=108,R=171))
         ColorScale(3)=(RelativeTime=1.000000)
         CoordinateSystem=PTCS_Relative
         MaxParticles=6
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=32.000000,Max=64.000000)
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Fire.SmokeFragment'
         LifetimeRange=(Min=0.500000,Max=0.750000)
         StartVelocityRadialRange=(Min=50.000000,Max=80.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(2)=SpriteEmitter'OnslaughtBP.ONSShockTankShockExplosion.SpriteEmitter1'

     AutoDestroy=True
     bNoDelete=False
     bHighDetail=True
     Skins(0)=Texture'ONSBPTextures.fX.Missile'
}
