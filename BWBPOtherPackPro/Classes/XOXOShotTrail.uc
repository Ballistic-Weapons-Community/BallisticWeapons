class XOXOShotTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter114
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(B=192,G=128,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=255,G=192,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=192,G=255,R=128))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         Opacity=0.550000
         FadeOutStartTime=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.XOXOShotTrail.SpriteEmitter114'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=100.000000
         UseCrossedSheets=True
         PointLifeTime=0.750000
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.700000,Max=0.700000))
         Opacity=0.600000
         MaxParticles=1
         StartSizeRange=(X=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(1)=TrailEmitter'BWBPOtherPackPro.XOXOShotTrail.TrailEmitter1'

}
