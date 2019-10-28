//=============================================================================
// RSNova2Trail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNova2Trail extends BallisticEmitter;

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter23
         UseColorScale=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=192,R=128))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=128,R=64))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=20.000000)
         StartSizeRange=(X=(Min=40.000000,Max=50.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.100000,Max=0.200000)
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSNova2Trail.SpriteEmitter23'

     Begin Object Class=TrailEmitter Name=TrailEmitter6
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=150
         DistanceThreshold=50.000000
         UseCrossedSheets=True
         PointLifeTime=2.000000
         FadeOut=True
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorMultiplierRange=(Y=(Min=0.700000),Z=(Min=0.200000,Max=0.500000))
         Opacity=0.300000
         FadeOutStartTime=0.100000
         MaxParticles=1
         DetailMode=DM_SuperHigh
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=2.000000,Max=3.000000))
         InitialParticlesPerSecond=500000.000000
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=9999.000000,Max=9999.000000)
     End Object
     Emitters(1)=TrailEmitter'BallisticProV55.RSNova2Trail.TrailEmitter6'

}
