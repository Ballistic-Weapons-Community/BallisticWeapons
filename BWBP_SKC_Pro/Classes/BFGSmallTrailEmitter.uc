//=============================================================================
// A73TrailEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BFGSmallTrailEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         ColorScale(0)=(Color=(G=255,R=64))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=255,R=75))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.100000),Y=(Min=2.000000,Max=4.000000),Z=(Min=0.000000,Max=0.500000))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         DetailMode=DM_High
         StartLocationOffset=(X=100.000000)
         StartSizeRange=(X=(Min=160.000000,Max=180.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP_SKC_Tex.A73b.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BWBP_SKC_Pro.BFGSmallTrailEmitter.SpriteEmitter1'

     Begin Object Class=TrailEmitter Name=TrailEmitter1
         TrailShadeType=PTTST_PointLife
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=1000
         DistanceThreshold=1000.000000
         PointLifeTime=3.500000
         FadeOut=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.100000),Y=(Min=2.000000,Max=4.000000),Z=(Min=0.000000,Max=0.500000))
         Opacity=0.400000
         FadeOutStartTime=0.100000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SizeScale(1)=(RelativeTime=0.550000,RelativeSize=1.200000)
         SizeScale(2)=(RelativeTime=1.500000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=4.000000,Max=5.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BWBP_SKC_Tex.A73b.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=6.000000,Max=6.000000)
     End Object
     Emitters(1)=TrailEmitter'BWBP_SKC_Pro.BFGSmallTrailEmitter.TrailEmitter1'

}
