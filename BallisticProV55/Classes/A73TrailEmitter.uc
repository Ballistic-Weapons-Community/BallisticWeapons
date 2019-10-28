//=============================================================================
// A73TrailEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A73TrailEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=160,R=160))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=64,R=64))
         Opacity=0.700000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=100.000000)
         StartSizeRange=(X=(Min=60.000000,Max=80.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A73TrailEmitter.SpriteEmitter1'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=50.000000
         UseCrossedSheets=True
         PointLifeTime=0.250000
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
         Opacity=0.700000
         MaxParticles=1
         StartSizeRange=(X=(Min=4.000000,Max=5.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.A73TrailEmitter.TrailEmitter0'

     Physics=PHYS_Trailer
}
