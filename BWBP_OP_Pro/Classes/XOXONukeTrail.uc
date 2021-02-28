class XOXONukeTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter155
         UseColorScale=True
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=160,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=64,R=255))
         ColorScaleRepeats=1.000000
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.400000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         DetailMode=DM_High
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=120.000000,Max=120.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_OP_Pro.XOXONukeTrail.SpriteEmitter155'

     Begin Object Class=TrailEmitter Name=TrailEmitter3
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=50.000000
         UseCrossedSheets=True
         PointLifeTime=0.750000
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.500000),Z=(Min=0.600000,Max=0.700000))
         Opacity=0.700000
         MaxParticles=1
         StartSizeRange=(X=(Min=6.000000,Max=7.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BWBP_OP_Tex.XOXO.xenon4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(1)=TrailEmitter'BWBP_OP_Pro.XOXONukeTrail.TrailEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter156
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000),Y=(Min=0.000000),Z=(Min=0.000000))
         FadeOutStartTime=0.750000
         FadeInEndTime=0.750000
         MaxParticles=16
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         Texture=Texture'BWBP_OP_Tex.XOXO.hearteffect'
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_OP_Pro.XOXONukeTrail.SpriteEmitter156'

}
