//=============================================================================
// MACBeaconTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACBeaconTrail extends DGVEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=70.000000,Max=70.000000),Y=(Min=70.000000,Max=70.000000),Z=(Min=70.000000,Max=70.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.MACBeaconTrail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'BWBP4-Tex.DarkStar.HotFlareA2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.MACBeaconTrail.SpriteEmitter1'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=350
         DistanceThreshold=30.000000
         UseCrossedSheets=True
         PointLifeTime=8.000000
         UseColorScale=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=64,G=64,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=64,R=255,A=255))
         ColorMultiplierRange=(X=(Min=2.000000,Max=2.000000))
         MaxParticles=1
         StartSizeRange=(X=(Min=40.000000,Max=40.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BWBP4-Tex.Glock.LaserBeam'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=500.000000,Max=500.000000)
     End Object
     Emitters(2)=TrailEmitter'BallisticProV55.MACBeaconTrail.TrailEmitter0'

     AutoDestroy=True
     bHardAttach=True
}
