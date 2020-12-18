//=============================================================================
// MRLTrailEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLTrailEmitter extends BallisticEmitter;

/*    Begin Object Class=TrailEmitter Name=TrailEmitter0
        TrailShadeType=PTTST_PointLife
        TrailLocation=PTTL_FollowEmitter
        MaxPointsPerTrail=50
        DistanceThreshold=500.000000
        PointLifeTime=3.500000
        FadeOut=True
        UniformSize=True
        AutomaticInitialSpawning=False
        Opacity=0.500000
        DrawStyle=PTDS_Brighten
        FadeOutStartTime=0.300000
        MaxParticles=1
        DetailMode=DM_SuperHigh
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=3.000000,Max=3.000000))
        InitialParticlesPerSecond=500000.000000
        Texture=Texture'BallisticEffects.Particles.Smoke3'
//		Texture=Texture'BallisticEffects.Particles.HotFlareA1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=3.500000,Max=3.500000)
    End Object
    Emitters(0)=TrailEmitter'MRLTrailEmitter.TrailEmitter0'
*/

defaultproperties
{
     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=20.000000
         UseCrossedSheets=True
         PointLifeTime=0.750000
         AutomaticInitialSpawning=False
         Opacity=0.500000
         MaxParticles=1
         StartSizeRange=(X=(Min=2.000000,Max=2.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(0)=TrailEmitter'BallisticProV55.MRLTrailEmitter.TrailEmitter0'

     Physics=PHYS_Trailer
     bHardAttach=True
}
