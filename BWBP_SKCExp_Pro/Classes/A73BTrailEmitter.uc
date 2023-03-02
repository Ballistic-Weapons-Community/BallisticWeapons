//=============================================================================
// A73TrailEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A73BTrailEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(G=128,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=255,R=255))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=100.000000)
         StartSizeRange=(X=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.A73b.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKCExp_Pro.A73BTrailEmitter.SpriteEmitter1'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=50
         DistanceThreshold=500.000000
         PointLifeTime=3.500000
         FadeOut=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         Opacity=0.600000
         FadeOutStartTime=0.100000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.800000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=4.000000,Max=5.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BWBP_SKC_Tex.A73b.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(1)=TrailEmitter'BWBP_SKCExp_Pro.A73BTrailEmitter.TrailEmitter1'

     bNoDelete=False
}
