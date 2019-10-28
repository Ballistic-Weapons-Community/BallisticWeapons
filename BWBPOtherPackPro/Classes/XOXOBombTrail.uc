class XOXOBombTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=XOXOBombFlare1
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
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=200.000000,Max=200.000000),Z=(Min=200.000000,Max=200.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.XOXOBombTrail.XOXOBombFlare1'

     Begin Object Class=TrailEmitter Name=XOXOBombFlare2
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
     Emitters(1)=TrailEmitter'BWBPOtherPackPro.XOXOBombTrail.XOXOBombFlare2'

     Begin Object Class=SpriteEmitter Name=XOXOBombHeart
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.500000
         FadeInEndTime=0.500000
         MaxParticles=8
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
         Texture=Texture'BWBPOtherPackTex.XOXO.hearteffect'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBPOtherPackPro.XOXOBombTrail.XOXOBombHeart'

}
