//=============================================================================
// MRLTrailEmitter_C.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLTrailEmitter_C extends BallisticEmitter;

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
         StartSizeRange=(X=(Min=3.000000,Max=3.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(0)=TrailEmitter'BallisticProV55.MRLTrailEmitter_C.TrailEmitter0'

     Physics=PHYS_Trailer
     bHardAttach=True
}
