//=============================================================================
// A42TrailEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class A42TrailEmitter extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=192,G=128,R=255))
         ColorScale(1)=(RelativeTime=0.800000,Color=(B=255,G=192,R=160,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=192,G=255,R=128))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.800000),Z=(Min=0.800000))
         Opacity=0.550000
         FadeOutStartTime=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=50.000000)
         StartSizeRange=(X=(Min=40.000000,Max=50.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.150000,Max=0.300000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.A42TrailEmitter.SpriteEmitter0'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=100.000000
         UseCrossedSheets=True
         PointLifeTime=0.750000
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.700000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.700000))
         Opacity=0.600000
         MaxParticles=1
         StartSizeRange=(X=(Min=3.000000,Max=4.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.A42TrailEmitter.TrailEmitter0'

}
