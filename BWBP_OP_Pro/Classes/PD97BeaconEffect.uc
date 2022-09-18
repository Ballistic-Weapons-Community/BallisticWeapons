//-----------------------------------------------------------
//Rocket Trail for Tarntula rocket projectile
//-----------------------------------------------------------
class PD97BeaconEffect extends Emitter;

#exec OBJ LOAD FILE=AS_FX_TX.utx

defaultproperties
{
     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=20.000000
         UseCrossedSheets=True
         PointLifeTime=1.000000
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.200000,Max=0.300000),Y=(Min=0.200000,Max=0.300000),Z=(Min=0.200000,Max=0.300000))
         MaxParticles=1
         StartSizeRange=(X=(Min=0.200000,Max=1.000000))
         InitialParticlesPerSecond=2000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(0)=TrailEmitter'BWBP_OP_Pro.PD97BeaconEffect.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         RespawnDeadParticles=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=True
         ColorScale(0)=(Color=(B=64,G=200,R=255))
         ColorScale(1)=(RelativeTime=0.750000,Color=(B=255,G=255,R=255))
         ColorScale(2)=(RelativeTime=1.000000)
         Opacity=0.590000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationOffset=(X=-10.000000)
         SpinCCWorCW=(X=0.000000,Y=0.000000,Z=0.000000)
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.050000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=0.250000,RelativeSize=0.750000)
         SizeScale(3)=(RelativeTime=0.400000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=5.000000,Max=7.500000))
         InitialParticlesPerSecond=50.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         InitialDelayRange=(Min=0.050000,Max=0.050000)
     End Object
     Emitters(1)=SpriteEmitter'BWBP_OP_Pro.PD97BeaconEffect.SpriteEmitter0'

	//Blinky Boy
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=4,G=4,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=4,G=4,R=200,A=255)))
         Opacity=0.130000
         FadeOutStartTime=0.990000
         FadeInEndTime=0.160000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         StartSizeRange=(X=(Min=10.500000,Max=12.000000))
         DrawStyle=PTDS_Alpha
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=3.000000)
     End Object
     Emitters(2)=SpriteEmitter'BWBP_OP_Pro.PD97BeaconEffect.SpriteEmitter3'

     AutoDestroy=True
     bNoDelete=False
     Physics=PHYS_Trailer
     bHardAttach=True
     bDirectional=True
}
