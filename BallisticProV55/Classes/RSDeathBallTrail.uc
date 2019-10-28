//=============================================================================
// RSDeathBallTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDeathBallTrail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=19.000000,Max=20.000000),Y=(Min=19.000000,Max=20.000000),Z=(Min=19.000000,Max=20.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'BWBP4-Tex.DarkStar.HotFlareA2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSDeathBallTrail.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.290000
         FadeInEndTime=0.065000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=16.000000,Max=18.000000),Y=(Min=16.000000,Max=18.000000),Z=(Min=16.000000,Max=18.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BWBP4-Tex.DarkStar.HotFlareA2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDeathBallTrail.SpriteEmitter0'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=350
         DistanceThreshold=30.000000
         PointLifeTime=1.000000
         UseColorScale=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255))
         MaxParticles=1
         StartSizeRange=(X=(Min=15.000000,Max=18.000000))
         InitialParticlesPerSecond=500000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(2)=TrailEmitter'BallisticProV55.RSDeathBallTrail.TrailEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.800000
         FadeOutStartTime=0.200000
         FadeInEndTime=0.150000
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         Texture=Texture'BallisticEffects.Particles.FlareC1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSDeathBallTrail.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
         Opacity=0.080000
         FadeOutStartTime=0.470000
         FadeInEndTime=0.040000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=250.000000)
         StartSizeRange=(X=(Min=35.000000,Max=45.000000),Y=(Min=35.000000,Max=45.000000),Z=(Min=35.000000,Max=45.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.Shockwave'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSDeathBallTrail.SpriteEmitter4'

     Physics=PHYS_Trailer
}
